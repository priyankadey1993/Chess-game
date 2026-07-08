import QtQuick
import QtQuick.Window

Window {
    width: 600
    height: 600
    visible: true
    title: "Full Chess Game - All Pieces"
    color: "#2f3542"

    // SAARI GOTIYAN SET KAR DI HAIN (Standard Chess Layout)
    property var boardState: [
        [4, 6, 8, 10, 12, 8, 6, 4], // Row 0: Black Pieces (Rook, Knight, Bishop, Queen, King...)
        [2, 2, 2,  2,  2, 2, 2, 2], // Row 1: Black Pawns
        [0, 0, 0,  0,  0, 0, 0, 0], // Row 2: Blank
        [0, 0, 0,  0,  0, 0, 0, 0], // Row 3: Blank
        [0, 0, 0,  0,  0, 0, 0, 0], // Row 4: Blank
        [0, 0, 0,  0,  0, 0, 0, 0], // Row 5: Blank
        [1, 1, 1,  1,  1, 1, 1, 1], // Row 6: White Pawns
        [3, 5, 7,  9, 11, 7, 5, 3]  // Row 7: White Pieces (Rook, Knight, Bishop, Queen, King...)
    ]

    property var selectedSquare: null

    Rectangle {
        width: 480
        height: 480
        anchors.centerIn: parent
        border.color: "#1e2124"
        border.width: 4

        Grid {
            id: chessGrid
            columns: 8
            rows: 8
            anchors.fill: parent

            Repeater {
                model: 64
                delegate: Rectangle {
                    id: squareItem
                    width: 60
                    height: 60

                    property int r: Math.floor(index / 8)
                    property int c: index % 8

                    color: (selectedSquare !== null && selectedSquare.row === r && selectedSquare.col === c)
                            ? "#f7d794"
                            : ((r + c) % 2 === 0 ? "#eeeed2" : "#769656")

                    // PIECE DISPLAY SWITCH LOGIC
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 38 // Gotiyon ka size thoda bada kiya hai

                        // BoardState ke number ke hisab se sahi emoji dikhane ke liye condition
                        text: {
                            var p = boardState[squareItem.r][squareItem.c];
                            if (p === 1) return "♙"; // White Pawn
                            if (p === 2) return "♟"; // Black Pawn
                            if (p === 3) return "♖"; // White Rook
                            if (p === 4) return "♜"; // Black Rook
                            if (p === 5) return "♘"; // White Knight
                            if (p === 6) return "♞"; // Black Knight
                            if (p === 7) return "♗"; // White Bishop
                            if (p === 8) return "♝"; // Black Bishop
                            if (p === 9) return "♕"; // White Queen
                            if (p === 10) return "♛"; // Black Queen
                            if (p === 11) return "♔"; // White King
                            if (p === 12) return "♚"; // Black King
                            return ""; //square
                        }

                        // White gotiyon ko thoda light aur black ko dark karne ke liye
                        color: boardState[squareItem.r][squareItem.c] % 2 === 1 ? "#ffffff" : "#1a1a1a"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (selectedSquare === null) {
                                if (boardState[squareItem.r][squareItem.c] !== 0) {
                                    selectedSquare = { "row": squareItem.r, "col": squareItem.c }
                                }
                            } else {
                                var oldR = selectedSquare.row
                                var oldC = selectedSquare.col

                                if (oldR !== squareItem.r || oldC !== squareItem.c) {
                                    var tempBoard = []
                                    for (var i = 0; i < 8; i++) {
                                        tempBoard.push([...boardState[i]])
                                    }

                                    tempBoard[squareItem.r][squareItem.c] = boardState[oldR][oldC]
                                    tempBoard[oldR][oldC] = 0

                                    boardState = tempBoard
                                }
                                selectedSquare = null
                            }
                        }
                    }
                }
            }
        }
    }
}