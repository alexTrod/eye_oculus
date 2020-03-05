#!/usr/bin/env python3

import socket
import selectors
import traceback
import json

from protocol_conversion import json_to_cmd

sel = selectors.DefaultSelector()
send_buffers = {}
recv_buffers = {}
conn_id = 0

# four characters in front of every command for micro-controller
# recognise based on command format whether a device is phone or micro-controller
# micro-controller always sends the message back if it has been received

# heating mode: fan oven -

host, port = '192.168.43.69', 8888  # hotspot 12
# host, port = 'localhost', 8888  # local
# host, port = '145.94.151.50', 8888  # eduroam (civil)

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
            if key.data is None:
                conn, addr = sock.accept()  # Should be ready to read
                print("accepted connection from", addr)
                conn.setblocking(False)
                sel.register(conn, selectors.EVENT_READ | selectors.EVENT_WRITE, data=conn_id)
                send_buffers[conn_id] = b""
                conn_id += 1
            else:
                try:
                    if mask & selectors.EVENT_READ:
                        data_recv = sock.recv(4096)
                        # add the new data to the send buffer of all other sockets
                        # here, we need to recognise which type of data it is. Based on that:
                        #   1. translate it if it comes from the phone, then put it in send buffer
                        #   2. if it comes from the micro-controller, do nothing
                        if data_recv:
                            try:
                                json_data = json.loads(data_recv)
                                cmds = b""
                                for json_key in json_data:
                                    cmds += bytes(json_to_cmd(json_key, json_data[json_key]), 'utf-8')
                                    print(cmds)
                                for conn in send_buffers:
                                    if conn is not key.data:
                                        send_buffers[conn] += cmds
                            except json.JSONDecodeError as e:  # find a better way to do this
                                print("Message could not be decoded:", e.doc)
                    elif mask & selectors.EVENT_WRITE:
                        send_buffer = send_buffers[key.data]
                        if send_buffer:
                            print("Sent info")
                            sent = sock.send(send_buffer + b"\n")
                            send_buffers[key.data] = send_buffer[sent:]  # remove sent bytes from buffer

                except Exception:
                    print("an exception occurred:", f"{traceback.format_exc()}")
                    try:
                        conn_id = sel.get_key(sock).data
                        del send_buffers[conn_id]
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
