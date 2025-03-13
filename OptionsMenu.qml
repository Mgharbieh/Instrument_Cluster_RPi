import QtQuick
import QtQuick.Layouts

Item {

    property int xPos: parent.x

    id: optMenuRoot

    Text
    {
        text: "⯅"
        width: 20
        font.pixelSize: 20
        font.bold: true
        color: "#4b4b4b"
        anchors
        {
            top: optMenuRoot.top
            horizontalCenter: parent.horizontalCenter
        }
    }

    Text
    {
        text: "⯆"
        width: 20
        font.pixelSize: 20
        font.bold: true
        color: "#4b4b4b"
        anchors
        {
            margins: -5
            bottom: optMenuRoot.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }

    Loader
    {
        id: menuLoader
        anchors.fill:parent

        sourceComponent:
        {
            if(rootWindow.currentSet === 1)
            {
                set1Component
            }
            else if (rootWindow.currentSet === 2)
            {
                set2Component
            }
            else if (rootWindow.currentSet === 3)
            {
                set3Component
            }
            else if(rootWindow.currentSet === 4)
            {
                set4Component
            }
            else if(rootWindow.currentSet === 5)
            {
                set5Component
            }
        }
        property alias columBarRef: optMenuRoot.parent
    }


    Component
    {
        id: set1Component

        GridLayout
        {
            columns: 1
            rows: 3

            rowSpacing: 5

            anchors.fill: menuLoader.columnBarRef
            anchors.margins: 10

            Rectangle
            {
                id: drivingProfile

                height: 130
                width: 290
                Layout.topMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 0) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Load Profile")
                    color: (counter === 0) ? "white" : "black"
                    font.pixelSize: 30
                    font.bold: true
                    y: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Current Profile: " + (rootWindow.driver + 1)
                    color: (counter === 0) ? "white" : "grey"
                    font.pixelSize: 20

                    y: 75
                    anchors.horizontalCenter: parent.horizontalCenter
                }

            }

            Rectangle
            {
                id: engineInfo

                height: 130
                width: 290
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 1) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Advanced View")
                    color:(counter === 1) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }
            }

            Rectangle
            {
                id: launchControl

                height: 130
                width: 290
                Layout.bottomMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 2) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Launch Control")
                    color: (counter === 2) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }
            }
        }

    }

    Component
    {
        id: set2Component

        GridLayout
        {
            columns: 1
            rows: 3

            rowSpacing: 5



            anchors.fill: menuLoader.columnBarRef
            anchors.margins: 10


            Rectangle
            {
                id: brakeBias

                height: 130
                width: 290
                Layout.topMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 3) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Brake Bias")
                    color: (counter === 3) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }
            }

            Rectangle
            {
                id: tractionControl

                height: 130
                width: 290
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 4) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Traction Control")
                    color: (counter === 4) ? "white" : "black"
                    font.pixelSize: 30
                    font.bold: true

                    y: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Current Value: " + tract.tractionSwitch
                    color: (counter === 4) ? "white" : "grey"
                    font.pixelSize: 20

                    y: 75
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle
            {
                id: launchSwitchAimRotary

                height: 130
                width: 290
                Layout.bottomMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 5) ? "#00a8ff" : "white"

                Text
                {
                    id: lineOne
                    text: qsTr("Launch Aim")
                    y: 40

                    color: (counter === 5) ? "white" : "black"
                    anchors.horizontalCenter: parent.horizontalCenter

                    font.pixelSize: 30
                    font.bold: true
                }

                Text {
                    text: "Current Value: <NULL>"
                    color: (counter === 5) ? "white" : "grey"
                    font.pixelSize: 20

                    y: 75
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    Component
    {
        id: set3Component

        GridLayout
        {
            columns: 1
            rows: 3

            rowSpacing: 5

            anchors.fill: menuLoader.columnBarRef
            anchors.margins: 10

            Rectangle
            {
                id: profile1

                height: 130
                width: 290
                Layout.topMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20



                color: (counter === 6) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr(" Profile 1")
                    color: (counter === 6) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }

            }

            Rectangle
            {
                id: profile2

                height: 130
                width: 290
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 7) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr(" Profile 2")
                    color:(counter === 7) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }
            }

            Rectangle
            {
                id: profile3

                height: 130
                width: 290
                Layout.bottomMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 8) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr(" Profile 3")
                    color: (counter === 8) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }
            }
        }
    }

    Component
    {
        id: set4Component

        GridLayout
        {
            columns: 1
            rows: 3

            rowSpacing: 5

            anchors.fill: menuLoader.columnBarRef
            anchors.margins: 10

            Rectangle
            {
                id: antiLag

                height: 130
                width: 290
                Layout.topMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20



                color: (counter === 9) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Anti Lag")
                    color: (counter === 9) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }

            }

            Rectangle
            {
                id: ignitionTiming

                height: 130
                width: 290
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 10) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Ignition Timing")
                    color:(counter === 10) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }
            }

            Rectangle
            {
                id: mixAim

                height: 130
                width: 290
                Layout.bottomMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: (counter === 11) ? "#00a8ff" : "white"

                Text
                {
                    text: qsTr("Fuel Mix Aim")
                    color: (counter === 11) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }
            }
        }
    }

    Component
    {
        id: set5Component

        GridLayout
        {
            columns: 1
            rows: 3

            rowSpacing: 5

            anchors.fill: menuLoader.columnBarRef
            anchors.margins: 10

            Rectangle
            {
                id: throttlePedalTranslation

                height: 130
                width: 290
                Layout.topMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20



                color: (counter === 12) ? "#00a8ff" : "white"

                Text
                {
                    id: lineOne
                    text: qsTr("Throttle Pedal")

                    color: (counter === 12) ? "white" : "black"
                    anchors
                    {
                        top: throttlePedalTranslation.top
                        horizontalCenter: throttlePedalTranslation.horizontalCenter
                        topMargin: 30
                    }

                    font.pixelSize: 30
                    font.bold: true
                }

                Text
                {
                    text: qsTr("Translation")

                    color: (counter === 12) ? "white" : "black"
                    anchors
                    {
                        top: lineOne.bottom
                        horizontalCenter: throttlePedalTranslation.horizontalCenter
                    }

                    font.pixelSize: 30
                    font.bold: true
                }

            }

            Rectangle
            {
                id: unusedSlot1

                height: 130
                width: 290
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: "transparent"

                /*(Text
                {
                    text: qsTr("Ignition Timing")
                    color:(counter === 10) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }*/
            }

            Rectangle
            {
                id: unusedSlot2

                height: 130
                width: 290
                Layout.bottomMargin: 25
                Layout.rightMargin: 5
                Layout.leftMargin: 5
                radius: 20

                color: "transparent"

                /*Text
                {
                    text: qsTr("Mix Aim")
                    color: (counter === 11) ? "white" : "black"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    font.bold: true
                }*/
            }
        }
    }
}



