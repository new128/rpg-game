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
            print(data.decode('utf-8'))

            break
    except Exception as e:
        print(f"Error: {e}")
    finally:
        # Закрываем соединение
        time.sleep(10)
        client_socket.close()


if __name__ == "__main__":
    HOST = '127.0.0.1'  # Локальный хост
    PORT = 12345  # Тот же порт, что и у сервера
    start_client(HOST, PORT)
