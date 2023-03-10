FROM python:3.9

WORKDIR /backend
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONBUFFERED 1
COPY ./requirements.txt /backend/requirements.txt

RUN apt-get update
RUN apt-get install -y --reinstall ca-certificates 
RUN apt install -y libgl1-mesa-glx python3-opencv poppler-utils postgresql-server-dev-all
RUN apt-get install 'ffmpeg'\
    'libsm6'\
    'libxext6'  -y
COPY ./uploadFile /backend/uploadFile 
COPY ./virtualStorage /backend/virtualStorage 
RUN pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host=files.pythonhosted.org --no-cache-dir --upgrade -r /backend/requirements.txt
COPY . /backend/
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
