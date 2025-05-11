import QtQuick

Window {
    id: window
    width: 640
    height: 360
    visible: true
    title: qsTr("Hello World")
    color: "#00414A"

    Image {
        id: image
        source: "qrc:/pics/logo.jpg"
        anchors.fill: parent // Make the image fill its parent (the Window)
        fillMode: Image.Stretch // Use Image.Stretch to make it stretch
    }

    component SquareButton: Rectangle {
        id: root

        // These are the signal declarations.
        signal activated(xPosition: real, yPosition: real)
        signal deactivated
        signal signaltest(message: string)

        property int side: 100
        width: side;
        height: side
        color: "#2CDE85"
        radius: 20

        MouseArea {
            anchors.fill: parent
            // This will emit the signal when the mouse is released.
            onReleased: {
                root.deactivated()
                root.signaltest("Button released!") // Emit signaltest
            }
            /*
              This will emit the signal when the mouse is pressed.
              The mouse position is passed as an argument.
            */
            onPressed: (mouse) => {
                root.activated(mouse.x, mouse.y)
                root.signaltest("Button pressed!") // Emit signaltest
            }
        }
    }

    SquareButton {
        id: secondButton // Unique id for the first instance
        color: "#FF0000" // Override the color property for this instance
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 50

        property int squareWidth: 150
        property string textToShow: "Click on me!"

        width: squareWidth

        // Define a JavaScript function to handle the signal
        function handleSignaltest(message) {
            console.log("Second Button Signaltest received with message:", message)
        }

        // Connect the signal to the JavaScript function
        onSignaltest: (message) => handleSignaltest(message)
        // This will print "Deactivated" when the mouse is released.
        onDeactivated: {
            console.log("Second Button Deactivated")
            secondButton.width = squareWidth
            textToShow = "Click on me"
        }
        // This will print "Activated at: <xPosition> <yPosition>" when the mouse is pressed.
        onActivated: function(xPosition, yPosition) {
            console.log("Second Button Activated at:", xPosition, yPosition); // Corrected line
            secondButton.width = 200
            textToShow = "ahhh release me!"
        }

        Rectangle {
            id: blueRectId
            width: secondButton.width / 2
            height: secondButton.height / 2
            anchors.centerIn: parent
            color: "dodgerblue"

            Text {
                id: textId
                anchors.centerIn: parent
                text: secondButton.textToShow
            }
        }
    }

    SquareButton {
        id: firstButton // Unique id for the first instance
        // Define a JavaScript function to handle the signal
        function handleSignaltest(message) {
            console.log("Signaltest received with message:", message)
        }

        // Connect the signal to the JavaScript function
        onSignaltest: (message) => handleSignaltest(message)
        // This will print "Deactivated" when the mouse is released.
        onDeactivated: console.log("Deactivated")
        // This will print "Activated at: <xPosition> <yPosition>" when the mouse is pressed.
        onActivated: function(xPosition, yPosition) {
            console.log("First Button Activated at:", xPosition, yPosition);
            firstButton.x += 20; // Move to the right by 20 pixels
            firstButton.y += 10; // Move down by 10 pixels
            firstButton.rotation += 45

            if (firstButton.x >= parent.width) {
                firstButton.x = 0
                firstButton.y = 0
            } else if (firstButton.y >= parent.height) {
                firstButton.x = 0
                firstButton.y = 0
            }
        }

        Rectangle {
            id: pinkRectId
            width: firstButton.width / 2
            height: firstButton.height / 2
            anchors.centerIn: parent
            color: "#FF00FF"
        }
    }
    Component.onCompleted: {
        console.log("View loaded!")
    }
}
