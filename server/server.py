import socket
import selectors
import traceback
import json

from protocol_conversion import json_to_cmd, cmd_to_json

# host, port = '192.168.43.69', 8888  # hotspot 12
host, port = 'localhost', 8888  # local
# host, port = '145.94.151.50', 8888  # eduroam (civil)
# host, port = '145.94.150.241', 8888  # eduroam (library)

sel = selectors.DefaultSelector()
send_buffers = {}
phones = []  # no difference is made between phones
appliances = []
conn_id = 0

PHONE_RESP = b'HTTP/1.1 200 OK\r\n\r\n'
APPLIANCE_RESP = b'ACK'
PHONE_CODE = b'HTTP'
APPLIANCE_CODE = b'ACK'


def broadcast(data, to_phones):
    for conn in send_buffers:
        if (conn in phones and to_phones) or not (conn in phones or to_phones):
            send_buffers[conn] += data


def is_phone(data, c_id):
    if c_id in phones:
        return True

    if PHONE_CODE in data:
        phones.append(c_id)
        return True


def is_appliance(data, c_id):
    if c_id in appliances:
        return True

    if APPLIANCE_CODE in data:
        appliances.append(c_id)
        return True


def handle_phone_data(data):
    try:
        cmd = json_to_cmd(data)
        # send_buffers[key.data] += HTTP_RESP  # send response to app
        broadcast(cmd, False)
    except json.JSONDecodeError:
        pass


def handle_appliance_data(data):
    if len(data) == 5 and data_recv[:3].isdigit():  # the last character of the argument may be T of F
        json_data = cmd_to_json(data_recv)
        broadcast(PHONE_RESP + json_data, True)

    elif PHONE_RESP in data_recv:  # send empty response to phone
        broadcast(PHONE_RESP, key.data)


lsock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# Avoid bind() exception: OSError: [Errno 48] Address already in use
lsock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
lsock.bind((host, port))
lsock.listen()
print("listening on", (host, port))
lsock.setblocking(False)
sel.register(lsock, selectors.EVENT_READ, data=None)

try:
    while True:
        events = sel.select(timeout=None)

        for key, mask in events:
            sock = key.fileobj

            if key.data is None:  # Accept new connection
                conn, addr = sock.accept()  # Should be ready to read
                print("accepted connection from", addr)
                conn.setblocking(False)
                sel.register(conn, selectors.EVENT_READ | selectors.EVENT_WRITE, data=conn_id)
                send_buffers[conn_id] = b""
                conn_id += 1

            else:  # handle existing connection
                try:
                    if mask & selectors.EVENT_READ:
                        data_recv = sock.recv(4096)
                        if data_recv:
                            print("received", data_recv, end=" ")

                            if is_phone(data_recv, key.data):
                                print("from a phone")
                                handle_phone_data(data_recv)

                            elif is_appliance(data_recv, key.data):
                                print("from an appliance")
                                handle_appliance_data(data_recv)

                    elif mask & selectors.EVENT_WRITE:
                        send_buffer = send_buffers[key.data]

                        if send_buffer:
                            sent = sock.send(send_buffer)
                            print("sent", send_buffer[:sent])
                            send_buffers[key.data] = send_buffer[sent:]  # remove sent bytes from buffer

                except Exception:
                    print("an exception occurred:", f"{traceback.format_exc()}")
                    try:
                        problem_id = sel.get_key(sock).data
                        del send_buffers[problem_id]
                        sel.unregister(sock)
                    except Exception as e:
                        print(f"error: selector.unregister() exception: {repr(e)}")
                    try:
                        sock.close()
                    except OSError as e:
                        print(f"error: socket.close() exception: {repr(e)}")

except KeyboardInterrupt:
    print("caught keyboard interrupt, exiting")
finally:
    sel.close()
