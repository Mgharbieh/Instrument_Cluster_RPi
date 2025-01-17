import Dyno_Info

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

Window
{
    id: root
    //test comment

    property var info: JSON

    property bool loadingComplete: false
    property bool displayProfiles: false
    property int speed: 0
    property int currentSet: 1
    property int counter: 0
    //property int biasVal: JSON.biasVal
    //property int rearBrakeBias: (100 - JSON.biasVal)
    property int driver: JSON.driver
    property int tractionSwitch: JSON.tractionSwitch

    width: 800
    height: 480
    visible: true
    title: qsTr("2025 Vehicle Display")
    color: "black"

    flags: Qt.FramelessWindowHint

    Material.theme: Material.Light

    JSONmanager {
        id: jsonManager
    }

    Image
    {
        id: loadingImage
        anchors.centerIn: parent
        source: "assets/images/teamlogo.png"
        visible: !root.loadingComplete


        Rectangle {
            id: dotContainer
            width: 120
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: loadingImage.bottom
            anchors.topMargin: 10
            color: "transparent"


            Rectangle
            {
                id: dot_1
                width: 20
                height: 20
                color: "#FFCB05"
                radius: 100
                anchors.left: parent.left
                SequentialAnimation
                {
                    running: true
                    loops: Animation.Infinite
                    ScaleAnimator
                    {
                        target: dot_1
                        from: 1
                        to: 0
                        duration: 840
                    }
                    ScaleAnimator
                    {
                        target: dot_1
                        from: 0
                        to: 1
                        duration: 840
                    }
                }
            }


            Rectangle
            {
                id: dot_2
                width: 20
                height: 20
                color: "#FFCB05"
                radius: 100
                anchors.left: dot_1.right
                anchors.leftMargin: 10
                SequentialAnimation
                {
                    running: true
                    PauseAnimation { duration: 120 }
                    SequentialAnimation {
                        loops: Animation.Infinite
                        ScaleAnimator
                        {
                            target: dot_2
                            from: 1
                            to: 0
                            duration: 840
                        }
                        ScaleAnimator
                        {
                            target: dot_2
                            from: 0
                            to: 1
                            duration: 840
                        }
                    }
                }
            }


            Rectangle
            {
                id: dot_3
                width: 20
                height: 20
                color: "#FFCB05"
                radius: 100
                anchors.left: dot_2.right
                anchors.leftMargin: 10
                SequentialAnimation
                {
                    running: true
                    PauseAnimation { duration: 240 }
                    SequentialAnimation
                    {
                        loops: Animation.Infinite
                        ScaleAnimator
                        {
                            target: dot_3
                            from: 1
                            to: 0
                            duration: 840
                        }
                        ScaleAnimator
                        {
                            target: dot_3
                            from: 0
                            to: 1
                            duration: 840
                        }
                    }
                }
            }


            Rectangle
            {
                id: dot_4
                width: 20
                height: 20
                color: "#FFCB05"
                radius: 100
                anchors.left: dot_3.right
                anchors.leftMargin: 10
                SequentialAnimation
                {
                    running: true
                    PauseAnimation { duration: 360 }
                    SequentialAnimation
                    {
                        loops: Animation.Infinite
                        ScaleAnimator
                        {
                            target: dot_4
                            from: 1
                            to: 0
                            duration: 840
                        }
                        ScaleAnimator
                        {
                            target: dot_4
                            from: 0
                            to: 1
                            duration: 840
                        }
                    }
                }
            }
        }
    }

    Timer
    {
        id: loadingTimer
        interval: 2000
        running: true
        repeat: false
        onTriggered:
        {
            root.loadingComplete = true
        }
    }


    Rectangle
    {
        id: uselessRectangle
        anchors
        {
            top: parent.top
            right: parent.right

        }
        width: 1040
        height: 0
        color: "transparent"
        visible: root.loadingComplete
    }

    Image
    {
        anchors
        {
            top: parent.top
            right: parent.right
        }
        width: 70
        height: 70
        source: "assets/images/teamlogo2.png"
        visible: root.loadingComplete
    }

    // anchors for icons on top of screen
    /*Rectangle
    {
        id: mainWindowAnchors

        width: 800
        height: 480

        Rectangle
        {
            id: informationBar

            height: 60
            width: 300
            color: "red"
            visible: true

            anchors
            {
                left: mainWindowAnchors.left
                right: mainWindowAnchors.right
                top: mainWindowAnchors.top
                margins: 20
            }
        }
    }*/

    Rectangle
    {
        id: visualRoot
        width: 800
        height: 480
        color: "transparent"

        Rectangle
        {
            id: speedometer
            anchors.centerIn: visualRoot
            width: 200
            height: 200

            color: "transparent"

            Rectangle
            {
                id: speedoNumber
                width: 150
                height: 150
                color: "transparent"
                anchors.centerIn: speedometer

                Text
                {
                    text: root.speed
                    color: "white"
                    anchors.centerIn: speedoNumber
                    font.pixelSize: 110
                    font.bold: true
                    visible: root.loadingComplete
                }
            }

            Rectangle
            {
                id: speedoUnit
                width: 100
                height: 5
                color: "transparent"

                anchors
                {
                    top: speedoNumber.bottom
                    horizontalCenter: speedoNumber.horizontalCenter
                    topMargin: 10
                }

                Text
                {
                    anchors.centerIn: parent
                    text: qsTr("MPH")
                    font.pixelSize: 60
                    font.bold: true
                    color: "#1e272e"
                    visible: root.loadingComplete
                }
            }

            PropertyAnimation
            {
               id: animationRightSpeedometer
               target: visualRoot
               property: "x"
               to: 165
               duration: 300
            }

            PropertyAnimation
            {
               id: animationLeftSpeedometer
               target: visualRoot
               property: "x"
               to: speedoNumber.horizontalCenter
               duration: 350
            }

            PropertyAnimation
            {
               id: animationUpSpeedometer
               target: visualRoot
               property: "y"
               to: -180
               duration: 200
            }

            PropertyAnimation
            {
               id: animationDownSpeedometer
               target: visualRoot
               property: "y"
               to: speedoNumber.verticalCenter
               duration: 300
            }

            PropertyAnimation
            {
               id: animationTopLeftSpeedometer
               target: visualRoot
               property: "x"
               to: -320
               duration: 200
            }
        }
    }

    Text
    {
        id: speedoUnitInfoScreen

        x: 130
        y: -20
        text: qsTr("MPH")
        font.pixelSize: 40
        font.bold: true
        color: "#1e272e"
        visible: false
    }

    PropertyAnimation
    {
       id: animationDownInfoScreenSpeedometer
       target: speedoUnitInfoScreen
       property: "y"
       to: 60
       duration: 300
    }

    PropertyAnimation
    {
       id: animationUpInfoScreenSpeedometer
       target: speedoUnitInfoScreen
       property: "y"
       to: -20
       duration: 300
    }

    Rectangle
    {
        id: columnBar

        anchors
        {
            top: uselessRectangle.bottom
            bottom: parent.bottom
            margins: 15
        }

        width: 300
        height: 50
        radius: 20
        color: "#1E1E1E"
        x: -columnBar.width
        visible: true

        Text
        {
            text: "⯅"
            width: 20
            font.pixelSize: 20
            font.bold: true
            color: "#4b4b4b"
            anchors
            {
                top: columnBar.top
                horizontalCenter: columnBar.horizontalCenter
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
                bottom: columnBar.bottom
                horizontalCenter: columnBar.horizontalCenter
            }
        }

        Loader
        {
            id: menuLoader
            anchors.fill:parent

            sourceComponent:
            {
                if(root.currentSet === 1)
                {
                    set1Component
                }
                else if (root.currentSet === 2)
                {
                    set2Component
                }
                else if (root.currentSet === 3)
                {
                    set3Component
                }
            }
            property alias columBarRef: columnBar
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

                    color: (root.counter === 0) ? "#00a8ff" : "white"

                    Text
                    {
                        text: qsTr("Load Profile")
                        color: (root.counter === 0) ? "white" : "black"
                        anchors.centerIn: parent
                        font.pixelSize: 30
                        font.bold: true
                    }

                }

                Rectangle
                {
                    id: brakeBias

                    height: 130
                    width: 290
                    Layout.rightMargin: 5
                    Layout.leftMargin: 5
                    radius: 20

                    color: (counter === 1) ? "#00a8ff" : "white"

                    Text
                    {
                        text: qsTr("Brake Bias")
                        color:(counter === 1) ? "white" : "black"
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
                    Layout.bottomMargin: 25
                    Layout.rightMargin: 5
                    Layout.leftMargin: 5
                    radius: 20

                    color: (counter === 2) ? "#00a8ff" : "white"

                    Text
                    {
                        text: qsTr("Traction Control")
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
                    id: engineInfo

                    height: 130
                    width: 290
                    Layout.topMargin: 25
                    Layout.rightMargin: 5
                    Layout.leftMargin: 5
                    radius: 20

                    color: (counter === 3) ? "#00a8ff" : "white"

                    Text
                    {
                        text: qsTr("Advanced View")
                        color: (counter === 3) ? "white" : "black"
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
                    Layout.rightMargin: 5
                    Layout.leftMargin: 5
                    radius: 20

                    color: (counter === 4) ? "#00a8ff" : "white"

                    Text
                    {
                        text: qsTr("Launch Control")
                        color: (counter === 4) ? "white" : "black"
                        anchors.centerIn: parent
                        font.pixelSize: 30
                        font.bold: true
                    }
                }

                Rectangle
                {
                    id: blankBox

                    height: 130
                    width: 290
                    Layout.bottomMargin: 25
                    Layout.rightMargin: 5
                    Layout.leftMargin: 5
                    radius: 20

                    color: "transparent"

                    /*Text
                    {
                        text: qsTr("Terrain Mode")
                        color: (counter === 5) ? "white" : "black"
                        anchors.centerIn: parent
                        font.pixelSize: 30
                        font.bold: true
                    }*/
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
    }





    PropertyAnimation
    {
       id: animationRight
       target: columnBar
       property: "x"
       to: root.width - 785
       duration: 300
    }

    PropertyAnimation
    {
       id: animationLeft
       target: columnBar
       property: "x"
       to: columnBar.width - root.width
       duration: 300
    }

    PropertyAnimation
    {
        id: engineInfoAnimationRight
        target: engineInfoScreen
        property: "x"
        to: visualRoot.right
        duration: 300
    }

    PropertyAnimation
    {
        id: engineInfoAnimationLeft
        target: engineInfoScreen
        property: "x"
        to: -800
        duration: 300
    }

    Rectangle
    {
        id: brakeBiasScreen
        radius: 25
        visible: false
        anchors
        {
            top: columnBar.top
            bottom: columnBar.bottom
            left: columnBar.left
            right: columnBar.right
        }

        BrakeBias
        {
            id: brakeBiasObject
            anchors.fill: parent
        }
    }

    Rectangle
        {
            id: tractionControlScreen
            radius: 25
            visible: false
            anchors
            {
                top: columnBar.top
                bottom: columnBar.bottom
                left: columnBar.left
                right: columnBar.right
            }

            TractionControl
            {
                id: tract
                anchors.fill: parent
                tractionValue: 5

            }
        }

    Rectangle
    {
        id: engineInfoScreen

        /*anchors
        {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }*/

        x: -800
        y: 140

        width: 800
        height: 310
        color: "transparent"
        visible: false

        Rectangle
        {
            id: spacer

            anchors
            {
                top: engineInfoScreen.top
                bottom: engineInfoScreen.bottom
                left: engineInfoScreen.left
            }

            width: 20
            //height: 280
            color: "transparent"
            visible: false
        }

        Flow
        {
            anchors
            {
                top: engineInfoScreen.top
                bottom: engineInfoScreen.bottom
                left: spacer.right
                right: engineInfoScreen.right
            }

            spacing: 10


            Rectangle
            {
                id: infoWidget1

                width: 375
                height: 150
                radius: 20
                color: "#1E1E1E"
                border.width: 3
                border.color: (root.counter === 9) ? "#00a8ff" : "#1E1E1E"

                ProgressBar
                {
                    id: widget1ProgressBar
                    from: 0
                    to: 100
                    value: 3
                    anchors.centerIn: infoWidget1

                    background: Rectangle
                    {
                        implicitWidth: 340
                        implicitHeight: 50
                        radius: 5
                        color: "transparent"
                    }

                    contentItem: Item
                    {
                        implicitWidth: 340
                        implicitHeight: 50

                        Rectangle
                        {
                            width: widget1ProgressBar.visualPosition * parent.width
                            height: parent.height
                            radius: 5
                            color: "#00FF00"
                            visible: !widget1ProgressBar.indeterminate
                        }
                    }
                }

                Rectangle
                {
                    id: uselessRectangle2
                    width: 340
                    height: 50
                    border.width: 3
                    border.color: "#E0E0E0"
                    color: "transparent"
                    radius: 5

                    anchors
                    {
                        centerIn: infoWidget1
                    }
                }

                Rectangle
                {
                    anchors
                    {
                        top: infoWidget1.top
                        left: infoWidget1.left
                        margins: 18
                    }

                    Text
                    {
                        id: infoWidget1TextLabel1
                        text: qsTr("Text Label")
                        color: "white"
                        font.pixelSize: 13
                    }
                }

                Rectangle
                {
                    anchors
                    {
                        top: infoWidget1.top
                        left: infoWidget1.left
                        leftMargin: 301
                        topMargin: 18
                        rightMargin: 18
                        bottomMargin: 18
                    }

                    Text
                    {
                        id: infoWidget1TextLabel2
                        text: qsTr("Text Label")
                        color: "white"
                        font.pixelSize: 13
                    }
                }

                Rectangle
                {
                    id: uselessRectangle3


                    anchors
                    {
                        top: widget1ProgressBar.bottom
                        horizontalCenter: uselessRectangle2.horizontalCenter
                        topMargin: 18
                    }

                    Text
                    {
                        id: infoWidget1TextLabel3
                        text: qsTr("Text Label")
                        color: "white"
                        font.pixelSize: 13
                        anchors.centerIn: uselessRectangle3
                    }
                }
            }

            Rectangle
            {
                id: infoWidget2

                width: 375
                height: 150
                radius: 20
                color: "#1E1E1E"
                border.width: 3
                border.color: (root.counter === 10) ? "#00a8ff" : "#1E1E1E"

                ProgressBar
                {
                    id: widget2ProgressBar
                    from: 0
                    to: 100
                    value: 3
                    anchors.centerIn: infoWidget2

                    background: Rectangle
                    {
                        implicitWidth: 340
                        implicitHeight: 50
                        radius: 5
                        color: "transparent"
                    }

                    contentItem: Item
                    {
                        implicitWidth: 340
                        implicitHeight: 50

                        Rectangle
                        {
                            width: widget2ProgressBar.visualPosition * parent.width
                            height: parent.height
                            radius: 5
                            color: "#00FF00"
                            visible: !widget2ProgressBar.indeterminate
                        }
                    }
                }

                Rectangle
                {
                    id: uselessRectangle4
                    width: 340
                    height: 50
                    border.width: 3
                    border.color: "#E0E0E0"
                    color: "transparent"
                    radius: 5

                    anchors
                    {
                        centerIn: infoWidget2
                    }
                }

                Rectangle
                {
                    anchors
                    {
                        top: infoWidget2.top
                        left: infoWidget2.left
                        margins: 18
                    }

                    Text
                    {
                        id: infoWidget2TextLabel1
                        text: qsTr("Text Label")
                        color: "white"
                        font.pixelSize: 13
                    }
                }

                Rectangle
                {
                    anchors
                    {
                        top: infoWidget2.top
                        left: infoWidget2.left
                        leftMargin: 301
                        topMargin: 18
                        rightMargin: 18
                        bottomMargin: 18
                    }

                    Text
                    {
                        id: infoWidget2TextLabel2
                        text: qsTr("Text Label")
                        color: "white"
                        font.pixelSize: 13
                    }
                }

                Rectangle
                {
                    id: uselessRectangle5


                    anchors
                    {
                        top: widget2ProgressBar.bottom
                        horizontalCenter: uselessRectangle4.horizontalCenter
                        topMargin: 18
                    }

                    Text
                    {
                        id: infoWidget2TextLabel3
                        text: qsTr("Text Label")
                        color: "white"
                        font.pixelSize: 13
                        anchors.centerIn: uselessRectangle5
                    }
                }
            }

            Rectangle
            {
                id: infoWidget3

                width: 247
                height: 160
                radius: 20
                color: "#1E1E1E"
                border.width: 3
                border.color: (root.counter === 11) ? "#00a8ff" : "#1E1E1E"

                Text
                {
                    id: widget3Info

                    text: qsTr("0")
                    color: "white"
                    font.pixelSize: 70
                    font.bold: true

                    anchors
                    {
                        top: infoWidget3.top
                        horizontalCenter: infoWidget3.horizontalCenter
                        margins: 3
                    }
                }

                Text
                {
                    text: qsTr("-")
                    color: "white"
                    font.pixelSize: 30
                    font.bold: false

                    anchors
                    {
                        horizontalCenter: infoWidget3.horizontalCenter
                        bottom: infoWidget3.bottom
                        bottomMargin: 15
                    }
                }
            }

            Rectangle
            {
                id: infoWidget4

                width: 247
                height: 160
                radius: 20
                color: "#1E1E1E"
                border.width: 3
                border.color: (root.counter === 12) ? "#00a8ff" : "#1E1E1E"

                Text
                {
                    id: widget4Info

                    text: qsTr("0")
                    color: "white"
                    font.pixelSize: 70
                    font.bold: true

                    anchors
                    {
                        top: infoWidget4.top
                        horizontalCenter: infoWidget4.horizontalCenter
                        margins: 3
                    }
                }

                Text
                {
                    text: qsTr("-")
                    color: "white"
                    font.pixelSize: 30
                    font.bold: false

                    anchors
                    {
                        horizontalCenter: infoWidget4.horizontalCenter
                        bottom: infoWidget4.bottom
                        bottomMargin: 15
                    }
                }
            }

            Rectangle
            {
                id: infoWidget5

                width: 246
                height: 160
                radius: 20
                color: "#1E1E1E"
                border.width: 3
                border.color: (root.counter === 13) ? "#00a8ff" : "#1E1E1E"

                Text
                {
                    id: widget5Info

                    text: qsTr("0")
                    color: "white"
                    font.pixelSize: 70
                    font.bold: true

                    anchors
                    {
                        top: infoWidget5.top
                        horizontalCenter: infoWidget5.horizontalCenter
                        margins: 3
                    }
                }

                Text
                {
                    text: qsTr("-")
                    color: "white"
                    font.pixelSize: 30
                    font.bold: false

                    anchors
                    {
                        horizontalCenter: infoWidget5.horizontalCenter
                        bottom: infoWidget5.bottom
                        bottomMargin: 15
                    }
                }
            }
        }

    }

    Rectangle
    {
        id: statusUpdate

        width: 230
        height: 45
        radius: 10
        y: 500

        anchors
        {
            horizontalCenter: visualRoot.horizontalCenter
        }

        color: "#1E1E1E"

        Text
        {
            id: statusMessage
            text: qsTr("Default")
            color: "white"
            font.bold: true
            font.pixelSize: 20

            anchors
            {
                left: statusImage.right
                right: statusUpdate.right
                verticalCenter: statusUpdate.verticalCenter
                margins: 15

            }
        }

        Image
        {
            id: statusImage
            source: "assets/images/INFO.png"
            height: 40
            width: 40

            anchors
            {
                verticalCenter: statusUpdate.verticalCenter
                left: statusUpdate.left
                margins: 5
            }
        }
    }

    SequentialAnimation
    {
        id: statusUpdateAnimation
        running: false

        PauseAnimation
        {
            duration: 600
        }

        ParallelAnimation
        {
            NumberAnimation
            {
                target: visualRoot
                property: "y"
                to: -50
                duration: 300
                easing.type: Easing.InOutQuad
            }


            NumberAnimation
            {
                id: statusUpdateAnimationUp
                target: statusUpdate
                property: "y"
                to: 330
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }


        PauseAnimation
        {
            duration: 1750
        }

        ParallelAnimation
        {
            NumberAnimation
            {
                id: statusUpdateAnimationDown
                target: statusUpdate
                property: "y"
                to: 500
                duration: 300
                easing.type: Easing.InOutQuad
            }

            NumberAnimation
            {
                target: visualRoot
                property: "y"
                to: 0
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }
    }



    Item
    {
        focus: true

        Keys.onPressed: (event) =>
        {
            if (event.key === Qt.Key_Right)
            {
                if(columnBar.x < 0)
                {
                    animationRightSpeedometer.start()
                    animationRight.start()
                }
                else if(brakeBiasScreen.visible === true)
                {
                    if(barSlider.value !== (100 - jsonManager.biasVal)) {
                        updateBias(driver, (100 - barSlider.value))
                        animationLeftSpeedometer.start()
                        animationLeft.start()

                        statusMessage.text = "Settings Updated"
                        statusImage.source = "assets/images/INFO.png"
                        statusMessage.font.pixelSize = 20
                        statusUpdateAnimation.start()

                        counter = 0
                        currentSet = 1
                        brakeBiasScreen.visible = false
                    }
                    else {
                        animationLeftSpeedometer.start()
                        animationLeft.start()

                        counter = 0
                        currentSet = 1
                        brakeBiasScreen.visible = false
                    }
                }
                else if(tractionControlScreen.visible === true)
                {
                    animationLeftSpeedometer.start()
                    animationLeft.start()

                    statusMessage.text = "Settings Updated"
                    statusImage.source = "assets/images/INFO.png"
                    statusMessage.font.pixelSize = 20
                    statusUpdateAnimation.start()

                    counter = 0
                    currentSet = 1
                    tractionControlScreen.visible = false
                }
                else if(columnBar.x > 0 && counter === 0)
                {
                    currentSet = 3
                    counter = 6
                }
                else if(currentSet === 3)
                {
                    loadNewProfile(counter - 6)
                    animationLeftSpeedometer.start()
                    animationLeft.start()

                    statusMessage.text = "Profile Loaded:  " + (driver + 1)
                    statusImage.source = "assets/images/INFO.png"
                    statusMessage.font.pixelSize = 14
                    statusUpdateAnimation.start()

                    counter = 0
                    currentSet = 1
                }

                else if(counter === 1)
                {
                    brakeBiasScreen.visible = true
                }
                else if(counter === 2)
                {
                    tractionControlScreen.visible = true
                }
                else if(counter === 3)
                {
                    columnBar.visible = false
                    engineInfoAnimationRight.start()
                    animationUpSpeedometer.start()
                    //animationLeftSpeedometer.start()
                    animationTopLeftSpeedometer.start()
                    animationDownInfoScreenSpeedometer.start()
                    engineInfoScreen.visible = true
                    speedoUnitInfoScreen.visible = true
                    speedoUnit.visible = false
                    counter = 9
                }
                else if(engineInfoScreen.visible === true && counter < 13)
                {
                   counter = counter + 1
                }
                else if(engineInfoScreen.visible === true && counter === 13)
                {
                    counter = 9
                }

            }
            else if(event.key === Qt.Key_Left)
            {
                if(counter >= 0 && counter <= 4 && engineInfoScreen.visible === false && brakeBiasScreen.visible === false && tractionControlScreen.visible === false)
                {
                    animationLeftSpeedometer.start()
                    animationLeft.start()
                    counter = 0
                    currentSet = 1
                }
                else if(counter === 6 || counter === 7 || counter === 8 && currentSet === 3)
                {
                    currentSet = 1
                    counter = 0
                    animationRight.start()
                }
                else if(counter === 1 && brakeBiasScreen.visible === true)
                {
                    if(barSlider.value !== (100 - jsonManager.biasVal)) {
                        updateBias(driver, (100 - barSlider.value))
                        brakeBiasScreen.visible = false
                        animationRight.start()
                        animationRightSpeedometer.start()

                        statusMessage.text = "Setting Updated"
                        statusImage.source = "assets/images/INFO.png"
                        statusMessage.font.pixelSize = 20
                        statusUpdateAnimation.start()

                        counter = 1
                        currentSet = 1
                    }
                    else {
                        brakeBiasScreen.visible = false
                        animationRight.start()
                        animationRightSpeedometer.start()

                        counter = 1
                        currentSet = 1
                    }
                }
                else if(counter === 2 && tractionControlScreen.visible === true)
                {
                    tractionControlScreen.visible = false
                    animationRight.start()
                    animationRightSpeedometer.start()
                    statusMessage.text = "Settings Updated"
                    statusImage.source = "assets/images/INFO.png"
                    statusMessage.font.pixelSize = 20
                    statusUpdateAnimation.start()
                    counter = 2
                    currentSet = 1
                }
                else if (counter === 9 && engineInfoScreen.visible === true)
                {
                    columnBar.visible = true
                    engineInfoAnimationLeft.start()
                    engineInfoScreen.visible = false
                    animationRight.start()
                    animationRightSpeedometer.start()
                    animationDownSpeedometer.start()
                    animationUpInfoScreenSpeedometer.start()
                    speedoUnit.visible = true
                    speedoUnitInfoScreen.visible = false
                    counter = 3
                    currentSet = 2
                }
                else if(counter > 9 && engineInfoScreen.visible === true)
                {
                    counter = counter - 1
                }


            }
            else if(event.key === Qt.Key_Down)
            {
                counter = counter + 1

                if(brakeBiasScreen.visible === true && brakeBiasObject.biasVal > 0 && brakeBiasObject.rearBrakeBias < 100)
                {
                    counter = 1
                    brakeBiasObject.biasVal -= 1
                    brakeBiasObject.rearBrakeBias += 1
                }
                else if(brakeBiasObject.biasVal >= 100 || brakeBiasObject.rearBrakeBias >= 100)
                {
                    counter = 1
                }
                else if(engineInfoScreen.visible === true)
                {
                    counter = 11
                }
                else if(tractionControlScreen.visible === true && tract.tractionValue > 0)
                {
                    counter = 2
                    tract.tractionValue = tract.tractionValue - 1
                }
                else if(counter > 2 && counter < 5)
                {
                    currentSet = 2
                }
                else if(counter < 2)
                {
                    currentSet = 1
                }
                else if(counter === 5 && currentSet === 2)
                {
                    currentSet = 1
                    counter = 0
                }
                else if(counter > 8)
                {
                    counter = 6
                }


            }
            else if(event.key === Qt.Key_Up)
            {
                counter = counter - 1

                if(brakeBiasScreen.visible === true && brakeBiasObject.biasVal < 100 && brakeBiasObject.rearBrakeBias > 0)
                {
                    counter = 1
                    brakeBiasObject.biasVal += 1
                    brakeBiasObject.rearBrakeBias -= 1
                }
                else if(brakeBiasObject.biasVal >= 100 || brakeBiasObject.rearBrakeBias >= 100)
                {
                    counter = 1
                }
                else if(engineInfoScreen.visible === true)
                {
                    counter = 9
                }
                else if(tractionControlScreen.visible === true && tract.tractionValue < 10)
                {
                    counter = 2
                    tract.tractionValue = tract.tractionValue + 1
                }
                else if(counter < 0)
                {
                    currentSet = 2
                    counter = 4
                }
                else if(counter === 2)
                {
                    currentSet = 1
                    counter = 2
                }
                else if(counter < 6 && currentSet === 3)
                {
                    counter = 8
                }
            }
            else if(event.key === Qt.Key_Escape)
            {
                close()
            }
            else if (event.key === Qt.Key_W)
            {
                statusImage.source = "assets/images/WARN.png"
                statusMessage.text = "ECU fault"
                statusMessage.text.pixelSize = 20
                statusUpdateAnimation.start()


            }
        }
    }

    function loadNewProfile(profileNum) {
        jsonManager.loadProfile(profileNum)

        driver = jsonManager.driver
        biasVal = jsonManager.biasVal
        rearBrakeBias = (100 - jsonManager.biasVal)
        tractionSwitch = jsonManager.tractionSwitch
    }

    function updateBias(profile, bias) {
        jsonManager.updateBrakeBias(profile, bias)

        biasVal = jsonManager.biasVal
        rearBrakeBias = (100 - jsonManager.biasVal)
    }

    function updateTraction(profile, traction) {
        jsonManager.updateTractionCtl(profile, traction)

        tractionSwitch = jsonManager.tractionSwitch
    }
}



