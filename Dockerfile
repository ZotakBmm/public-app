FROM python:3

WORKDIR /usr/src/app

ENV AQUA_SERVER_URL=http://192.168.49.2:31876
ENV AQUA_USERNAME=administrator
ENV AQUA_PASSWORD=Passw0rd

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY flask-app.py ./
EXPOSE 80

ADD https://get.aquasec.com/5.0.0/microscanner /
RUN chmod +x /microscanner
RUN /microscanner [--full-output] && rm /microscanner

CMD [ "python", "./flask-app.py" ]