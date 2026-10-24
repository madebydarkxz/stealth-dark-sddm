import QtQuick 2.15
import SddmComponents 2.0
import QtGraphicalEffects 1.15
import QtQuick.Controls 2.15

Item {
    id: root
    width: 1920
    height: 1080

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            var d = new Date()
            timeLabel.text = Qt.formatDateTime(d, "hh:mm")
            dayLabel.text = Qt.formatDateTime(d, "ddd").toUpperCase()
            dateLabel.text = Qt.formatDateTime(d, "dd MMMM, yyyy")
            
            var hr = d.getHours()
            var greeting = "Buonasera"
            if (hr < 12) greeting = "Buongiorno"
            else if (hr < 18) greeting = "Buon pomeriggio"
            
            greetingLabel.text = "<b> </b> " + greeting + ", " + userListId.currentText
        }
    }

    Image {
        id: bg
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        
        Rectangle {
            anchors.fill: parent
            color: Qt.rgba(0, 0, 0, 0.45)
        }
    }

    FastBlur {
        id: bgBlur
        anchors.fill: bg
        source: bg
        radius: 72
        visible: false
    }

    Item {
        id: mainContainer
        anchors.centerIn: parent
        opacity: 0
        scale: 0.95

        Behavior on opacity { NumberAnimation { duration: 500; easing.type: Easing.OutCubic } }
        Behavior on scale { NumberAnimation { duration: 500; easing.type: Easing.OutCubic } }

        Component.onCompleted: {
            mainContainer.opacity = 1
            mainContainer.scale = 1
        }

        BlurredCard {
            width: 360; height: 380; radius: 25
            blurSource: bgBlur
            absoluteX: 580; absoluteY: 190
            color: Qt.rgba(5/255, 5/255, 5/255, 0.70)
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -200
            anchors.verticalCenterOffset: -160

            Text {
                text: sddm.hostName
                color: "#777788"
                font.pixelSize: 14; font.family: "JetBrainsMono Nerd Font"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -140
            }
            Text {
                text: "Accedi"
                color: "#FFFFFF"
                font.pixelSize: 38; font.family: "JetBrainsMono Nerd Font"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -85
            }
            
            ComboBox {
                id: userListId
                width: 320; height: 70
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 25
                model: userModel
                textRole: "name"
                currentIndex: userModel.lastIndex

                background: Rectangle {
                    color: userListId.hovered ? Qt.rgba(0, 0, 0, 0.75) : Qt.rgba(0, 0, 0, 0.50)
                    radius: 18
                    border.color: userListId.hovered ? "#555566" : "#22222E"
                    border.width: 1
                    Behavior on color { ColorAnimation { duration: 200 } }
                    Behavior on border.color { ColorAnimation { duration: 200 } }
                }

                contentItem: Item {
                    Text {
                        text: "utente <b></b>"
                        color: "#777788"
                        font.pixelSize: 11; font.family: "JetBrainsMono Nerd Font"
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.topMargin: 10
                        anchors.leftMargin: 20
                    }
                    
                    Text {
                        text: "<b>" + userListId.currentText + "</b>"
                        color: "#FFFFFF"
                        font.pixelSize: 18; font.family: "JetBrainsMono Nerd Font"
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.bottomMargin: 14
                        anchors.leftMargin: 20
                    }
                }

                delegate: ItemDelegate {
                    width: userListId.width
                    height: 50
                    contentItem: Text {
                        text: "<b>" + model.name + "</b>"
                        color: highlighted ? "#FFFFFF" : "#888899"
                        font.pixelSize: 18; font.family: "JetBrainsMono Nerd Font"
                        verticalAlignment: Text.AlignVCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                    }
                    background: Rectangle {
                        color: parent.highlighted ? Qt.rgba(1, 1, 1, 0.12) : "transparent"
                        radius: 12
                    }
                }

                popup: Popup {
                    y: userListId.height + 5
                    width: userListId.width
                    implicitHeight: contentItem.implicitHeight
                    padding: 8

                    enter: Transition {
                        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 200; easing.type: Easing.OutCubic }
                        NumberAnimation { property: "scale"; from: 0.92; to: 1.0; duration: 200; easing.type: Easing.OutCubic }
                    }
                    exit: Transition {
                        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 150; easing.type: Easing.InCubic }
                        NumberAnimation { property: "scale"; from: 1.0; to: 0.92; duration: 150; easing.type: Easing.InCubic }
                    }

                    contentItem: ListView {
                        clip: true
                        implicitHeight: contentHeight
                        model: userListId.popup.visible ? userListId.delegateModel : null
                        currentIndex: userListId.highlightedIndex
                    }

                    background: Rectangle {
                        color: Qt.rgba(10/255, 10/255, 15/255, 0.90)
                        radius: 18
                        border.color: "#333344"
                        border.width: 1
                        layer.enabled: true
                        layer.effect: DropShadow {
                            radius: 16
                            color: Qt.rgba(0,0,0,0.8)
                        }
                    }
                }
            }

            Rectangle {
                id: passBox
                width: 320; height: 70; radius: 18
                color: passwordInput.activeFocus ? Qt.rgba(0, 0, 0, 0.8) : Qt.rgba(0, 0, 0, 0.5)
                border.color: passwordInput.activeFocus ? "#777788" : "#22222E"
                border.width: 1
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 115
                z: 3

                Behavior on color { ColorAnimation { duration: 200 } }
                Behavior on border.color { ColorAnimation { duration: 200 } }

                Text {
                    text: "password"
                    color: "#777788"
                    font.pixelSize: 11; font.family: "JetBrainsMono Nerd Font"
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.topMargin: 10
                    anchors.leftMargin: 20
                }

                TextInput {
                    id: passwordInput
                    anchors.fill: parent
                    anchors.leftMargin: 20
                    anchors.rightMargin: 20
                    anchors.bottomMargin: 8
                    anchors.topMargin: 25
                    verticalAlignment: TextInput.AlignVCenter
                    horizontalAlignment: TextInput.AlignLeft
                    color: "#FFFFFF"
                    font.pixelSize: 24; font.family: "JetBrainsMono Nerd Font"
                    font.letterSpacing: 4
                    echoMode: TextInput.Password
                    passwordCharacter: "●"
                    focus: true
                    onAccepted: {
                        sddm.login(userListId.currentText, passwordInput.text, sessionListId.currentIndex)
                    }
                }
            }
        }

        BlurredCard {
            width: 360; height: 160; radius: 25
            blurSource: bgBlur
            absoluteX: 580; absoluteY: 600
            color: Qt.rgba(5/255, 5/255, 5/255, 0.70)
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: -200
            anchors.verticalCenterOffset: 140

            Text {
                id: timeLabel
                text: "<b>00:00</b>"
                color: "#FFFFFF"
                font.pixelSize: 72; font.family: "JetBrainsMono Nerd Font"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -15
            }
            Text {
                id: greetingLabel
                text: "<b> </b> Benvenuto"
                color: "#888899"
                font.pixelSize: 14; font.family: "JetBrainsMono Nerd Font"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 55
            }
        }

        BlurredCard {
            width: 360; height: 380; radius: 25
            blurSource: bgBlur
            absoluteX: 980; absoluteY: 190
            color: Qt.rgba(5/255, 5/255, 5/255, 0.70)
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: 200
            anchors.verticalCenterOffset: -160
            z: 1

            Rectangle {
                width: 120; height: 120; radius: 60
                color: Qt.rgba(0, 0, 0, 0.5)
                border.color: "#333344"
                border.width: 1
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -90

                Text {
                    text: ""
                    color: "#FFFFFF"
                    font.pixelSize: 60; font.family: "JetBrainsMono Nerd Font"
                    anchors.centerIn: parent
                }
            }

            Text {
                id: dayLabel
                text: "<b>GIORNO</b>"
                color: "#FFFFFF"
                font.pixelSize: 34; font.family: "JetBrainsMono Nerd Font"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 15
            }
            Text {
                id: dateLabel
                text: "Data"
                color: "#888899"
                font.pixelSize: 14; font.family: "JetBrainsMono Nerd Font"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 60
            }
        }

        BlurredCard {
            width: 360; height: 320; radius: 25
            blurSource: bgBlur
            absoluteX: 980; absoluteY: 520
            color: Qt.rgba(5/255, 5/255, 5/255, 0.70)
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: 200
            anchors.verticalCenterOffset: 140
            z: 10 

            layer.enabled: true
            layer.effect: DropShadow {
                horizontalOffset: 0
                verticalOffset: 0
                radius: 12
                samples: 16
                color: Qt.rgba(0, 0, 0, 0.7)
            }

            Text {
                text: " <b></b> "
                color: "#FFFFFF"
                font.pixelSize: 24; font.family: "JetBrainsMono Nerd Font"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -130
            }
            Text {
                text: "CachyOS Linux"
                color: "#FFFFFF"
                font.pixelSize: 18; font.family: "JetBrainsMono Nerd Font"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -95
            }
            Text {
                text: sddm.hostName + " System"
                color: "#777788"
                font.pixelSize: 12; font.family: "JetBrainsMono Nerd Font"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -75
            }

            Rectangle {
                id: btnReboot
                width: 150; height: 75; radius: 18
                color: mouseReboot.containsMouse ? Qt.rgba(0, 0, 0, 0.75) : Qt.rgba(0, 0, 0, 0.50)
                border.color: mouseReboot.containsMouse ? "#555566" : "#22222E"
                border.width: 1
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: -85
                anchors.verticalCenterOffset: -10
                
                Behavior on color { ColorAnimation { duration: 150 } }
                Behavior on border.color { ColorAnimation { duration: 150 } }

                MouseArea {
                    id: mouseReboot
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: sddm.reboot()
                }

                Text {
                    text: "<b></b>"
                    color: "#FFFFFF"
                    font.pixelSize: 18; font.family: "JetBrainsMono Nerd Font"
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: -12
                }
                Text {
                    text: "Riavvia"
                    color: "#888899"
                    font.pixelSize: 12; font.family: "JetBrainsMono Nerd Font"
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 12
                }
            }

            Rectangle {
                id: btnPower
                width: 150; height: 75; radius: 18
                color: mousePower.containsMouse ? Qt.rgba(0, 0, 0, 0.75) : Qt.rgba(0, 0, 0, 0.50)
                border.color: mousePower.containsMouse ? "#555566" : "#22222E"
                border.width: 1
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: 85
                anchors.verticalCenterOffset: -10
                
                Behavior on color { ColorAnimation { duration: 150 } }
                Behavior on border.color { ColorAnimation { duration: 150 } }

                MouseArea {
                    id: mousePower
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: sddm.powerOff()
                }

                Text {
                    text: "<b></b>"
                    color: "#FFFFFF"
                    font.pixelSize: 18; font.family: "JetBrainsMono Nerd Font"
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: -12
                }
                Text {
                    text: "Spegni"
                    color: "#888899"
                    font.pixelSize: 12; font.family: "JetBrainsMono Nerd Font"
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 12
                }
            }

            Rectangle {
                width: 320; height: 65; radius: 18
                color: Qt.rgba(0, 0, 0, 0.50)
                border.color: "#22222E"
                border.width: 1
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 95

                ComboBox {
                    id: sessionListId
                    anchors.fill: parent
                    model: sessionModel
                    textRole: "name"
                    currentIndex: sessionModel.lastIndex

                    background: Rectangle {
                        color: "transparent"
                    }

                    contentItem: Item {
                        Text {
                            text: "Ambiente Desktop <b></b>"
                            color: "#777788"
                            font.pixelSize: 10; font.family: "JetBrainsMono Nerd Font"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: parent.top
                            anchors.topMargin: 8
                        }
                        Text {
                            text: "<b>" + sessionListId.currentText + "</b>"
                            color: "#FFFFFF"
                            font.pixelSize: 18; font.family: "JetBrainsMono Nerd Font"
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: 8
                        }
                    }

                    delegate: ItemDelegate {
                        width: sessionListId.width
                        height: 50
                        contentItem: Text {
                            text: "<b>" + model.name + "</b>"
                            color: highlighted ? "#FFFFFF" : "#888899"
                            font.pixelSize: 16; font.family: "JetBrainsMono Nerd Font"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                        background: Rectangle {
                            color: parent.highlighted ? Qt.rgba(1, 1, 1, 0.12) : "transparent"
                            radius: 12
                        }
                    }

                    popup: Popup {
                        y: sessionListId.height + 5
                        width: sessionListId.width
                        implicitHeight: contentItem.implicitHeight
                        padding: 8

                        enter: Transition {
                            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 200; easing.type: Easing.OutCubic }
                            NumberAnimation { property: "scale"; from: 0.92; to: 1.0; duration: 200; easing.type: Easing.OutCubic }
                        }
                        exit: Transition {
                            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 150; easing.type: Easing.InCubic }
                            NumberAnimation { property: "scale"; from: 1.0; to: 0.92; duration: 150; easing.type: Easing.InCubic }
                        }

                        contentItem: ListView {
                            clip: true
                            implicitHeight: contentHeight
                            model: sessionListId.popup.visible ? sessionListId.delegateModel : null
                            currentIndex: sessionListId.highlightedIndex
                        }

                        background: Rectangle {
                            color: Qt.rgba(10/255, 10/255, 15/255, 0.90)
                            radius: 18
                            border.color: "#333344"
                            border.width: 1
                            layer.enabled: true
                            layer.effect: DropShadow {
                                radius: 16
                                color: Qt.rgba(0,0,0,0.8)
                            }
                        }
                    }
                }
            }
            
            Connections {
                target: sddm
                function onLoginSucceeded() {}
                function onLoginFailed() {
                    passwordInput.text = ""
                    passBox.border.color = "#FF4444"
                }
            }
        }
    }
}
