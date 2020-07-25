.PHONY: build install test test-integration typecheck package clean

build: aw_qt/resources.py
	poetry install

install:
	bash scripts/config-autostart.sh

test:
	python -c 'import aw_qt'

test-integration:
	python ./tests/integration_tests.py --no-modules

typecheck:
	mypy aw_qt --ignore-missing-imports

precommit:
	make typecheck
	make test
	make test-integration

package:
	pyinstaller --clean --noconfirm --windowed aw-qt.spec

clean:
	rm -rf build dist
	rm -rf __pycache__ aw_qt/__pycache__

aw_qt/resources.py: aw_qt/resources.qrc
	pip3 install pyqt5
	pyrcc5 -o aw_qt/resources.py aw_qt/resources.qrc
