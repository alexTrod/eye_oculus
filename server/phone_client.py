import socket
import selectors
import traceback
import json

host, port = '192.168.43.69', 8888  # hotspot 12
# host, port = '145.94.151.50', 8888
# host, port = 'localhost', 8888
sel = selectors.DefaultSelector()

send_buf = b""

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setblocking(False)
s.connect_ex((host, port))
sel.register(s, selectors.EVENT_WRITE | selectors.EVENT_READ)

send_buf += bytes(json.dumps({"get temperature": 0}), 'utf-8')

running = True

while running:
    for key, mask in sel.select(timeout=None):
        try:
            if mask & selectors.EVENT_READ:
                data_recv = s.recv(4096)
                if data_recv:
                    print(data_recv)
            elif mask & selectors.EVENT_WRITE and send_buf:
                sent = s.send(send_buf)
                send_buf = send_buf[sent:]

        except Exception:
            print("an exception occurred:", f"{traceback.format_exc()}")
            running = False

sel.unregister(s)
s.close()
