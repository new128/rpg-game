import socket
import time


def start_client(host, port):
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((host, port))

    try:
        while True:
            data = client_socket.recv(1024)
            if not data:
                break
            print(f"Received from server: {data.decode('utf-8')}")
            if data.decode('utf-8') == "accept":
                with open('static/t.txt', 'w') as file:
                    file.write('t')
                while mes == "":
                    with open('static/text.txt', 'r') as file:
                        mes = file.read()
                client_socket.sendall(mes.encode('utf-8'))
                break
    except Exception as e:
        print(f"Error: {e}")
    finally:
        # Закрываем соединение
        time.sleep(5)
        data = client_socket.recv(1024)
        with open('static/game_server.txt', 'w') as file:
            file.write(data.decode('utf-8'))
        client_socket.close()


if __name__ == "__main__":
    HOST = '127.0.0.1'  # Локальный хост
    PORT = 12345  # Тот же порт, что и у сервера
    start_client(HOST, PORT)
