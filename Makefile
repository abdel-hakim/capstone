setup:
	python3 -m venv ./.venv

install:
	(\
		python3 -m venv ./.venv;\
		. .venv/bin/activate;\
		pip3 install -r requirements.txt;\
	)

lint:
	(\
		. .venv/bin/activate;\
		hadolint Dockerfile;\
		pylint --disable=R,C,W1203,W1202,W1309 app.py;\
	)