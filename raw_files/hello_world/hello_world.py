import sys
from PyQt5 import QtCore, QtWidgets
from PyQt5.QtWidgets import QMainWindow, QLabel, QGridLayout, QWidget
from PyQt5.QtCore import QSize
from PyQt5 import QtGui


class HelloWindow(QMainWindow):
    def __init__(self):
        QMainWindow.__init__(self)

        self.setMinimumSize(QSize(400, 400))
        self.setWindowTitle("Hello world")

        widget = QWidget(self)
        self.setCentralWidget(widget)
        gridLayout = QGridLayout(self)
        widget.setLayout(gridLayout)

        text = QLabel("Hello World \n für die IBZ Diplomarbeit", self)
        text.setFont(QtGui.QFont('SansSerif', 20))
        text.setAlignment(QtCore.Qt.AlignCenter)
        gridLayout.addWidget(text, 0, 0)


if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    mainWin = HelloWindow()
    mainWin.show()
    sys.exit(app.exec_())
