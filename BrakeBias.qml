import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

Item
{
    id: brakeBiasRoot
    property int biasVal: JSON.biasVal
    property int rearBrakeBias: (100 - JSON.biasVal)

    Rectangle
    {
        id: brakeBiasScreen

        anchors
        {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: parent.rrootight
        }

        width: 300
        height: 50
        radius: 20
        color: "#1E1E1E"

        Image
        {
            id: carImage
            anchors
            {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
                topMargin: 40
                bottomMargin: 40
                rightMargin: 0
            }

            width: 300
            height: 50

            source: "assets/images/raceCar.png"
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
                from: 0
                to: 100
                value: rearBrakeBias
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
            }
        }

        Rectangle
        {
            id: percentBarBottom
            anchors
            {
                top: carImage.bottom
                bottom: parent.bottom
                left: barSliderHolder.right
                right: parent.right
                margins: 7
            }

            color: "#4b4b4b"
            border.color: "#3d3d3d"
            border.width: 3
            width: 10
            height: 20
            radius: 30
        }

        Rectangle
        {
            id: percentBarTop
            anchors
            {
                top: parent.top
                bottom: carImage.top
                left: barSliderHolder.right
                right: parent.right
                margins: 7
            }

            color: "#4b4b4b"
            border.color: "#3d3d3d"
            border.width: 3
            width: 10
            height: 20
            radius: 30
        }

        Text
        {
            id: topSliderText
            anchors.centerIn: percentBarTop
            text: biasVal + "%"
            font.pixelSize: 15
            font.bold: true
            color: "white"
        }

        Text
        {
            id: bottomSliderText
            anchors.centerIn: percentBarBottom
            text: rearBrakeBias + "%"
            font.pixelSize: 15
            font.bold: true
            color: "white"
        }
    }
}
