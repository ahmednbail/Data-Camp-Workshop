FROM python:3.13-slim
RUN pip install pandas pyarrow
WORKDIR /code
COPY pipline/pipline.py .
ENTRYPOINT ["python", "pipline.py"]

