import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Window

Item
{
    //property int tractionValue
    property int tractionSwitch: JSON.tractionSwitch

    Rectangle
    {
        //id: tractionControlScreen

        anchors.fill: parent

        radius: 20
        color: "#1E1E1E"

        Rectangle {
            id: backgroundColor
            x: 75
            y: 145
            width: 220
            height: 150

            color {
                r:  if(tractionSwitch > 5) { ((255 - (51 * tractionSwitch)) / 255) }
                    else { 1 }

                g:  if(tractionSwitch < 5) { ((51* tractionSwitch) / 255) }
                    else { 1 }

                b: 0
                a: 1
            }
        }

        Image
        {
            id: tractionLogo
            anchors
            {
                top: parent.top
                //bottom: parent.bottom
                right: parent.right
                topMargin: 140
                //bottomMargin: 40
                leftMargin: 40
            }

            width: 239
            height: 174
            source: "assets/images/TractionControl.png"
        }


        Column
        {
            id: barSliderHolder

            anchors
            {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                topMargin: 20
                bottomMargin: 20
                leftMargin: 15
            }

            Slider
            {
                id: barSlider
                orientation: Qt.Vertical
                width: 30
                height: 410
                from: 10
                to: 1
                value: tractionSwitch
                enabled: false

                background: Rectangle
                {
                    width: 5
                    color: "#FFCB05"
                    border.color: "black"
                    border.width: 3
                    radius: 2
                    anchors.fill: parent
                    anchors.margins: 10
                }

                handle: Rectangle
                {
                    width: 30
                    height: 15
                    radius: 3
                    color: "white"
                    border.color: "black"
                    border.width: 3
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: barSlider.position * (barSlider.height - height)
                }

                Rectangle
                {
                    id: anchorBox
                    width: 80
                    height: 130
                    color: "transparent"

                    anchors
                    {
                        left: parent.left
                        verticalCenter: parent.verticalCenter
                        leftMargin: 110.5
                    }

                    Text
                    {
                        id: tractionDisplayValue
                        text: tractionSwitch
                        color: "white"
                        font.pixelSize: 40
                        font.bold: true

                        anchors{
                            horizontalCenter: parent.horizontalCenter
                            top: parent.top
                            topMargin: -125
                        }
                    }
                    /**
                    Text
                    {
                        text: "⯅"
                        width: 25
                        font.pixelSize: 25
                        font.bold: true
                        color: "white"
                        anchors
                        {
                            margins: 10
                            top: anchorBox.top
                            horizontalCenter: tractionDisplayValue.horizontalCenter
                        }
                    }

                    Text
                    {
                        text: "⯆"
                        width: 25
                        font.pixelSize: 25
                        font.bold: true
                        color: "white"
                        anchors
                        {
                            bottom: anchorBox.bottom
                            horizontalCenter: tractionDisplayValue.horizontalCenter
                        }
                    }
                    **/
                }
            }
        }
    }

    function updateTraction(profile, traction) {
        JSON.updateTractionCtl(profile, traction)
        canManager.updatePayload(1, (JSON.tractionSwitch *3)) // *3 bc motec rotary bullshit

        tractionSwitch = JSON.tractionSwitch
    }

}
