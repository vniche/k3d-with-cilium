FROM rancher/k3s:v1.21.2-k3s1

COPY ./k3s.sh /bin/k3s.sh
RUN chmod +x /bin/k3s.sh

ENTRYPOINT [ "/bin/k3s.sh" ]