import QtQuick

Window {
    id: window
    width: 640
    height: 360
    visible: true
    title: qsTr("Hello World")
    color: "#00414A"

    component SquareButton: Rectangle {
        id: root

        // These are the signal declarations.
        signal activated(xPosition:real, yPosition:real)
        signal deactivated
        signal signaltest(message: string)

        property int side: 100
        width: side; height: side
        color: "#2CDE85"

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

    SquareButton{
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
        onActivated: {
            (xPosition, yPosition) => console.log("Activated at:", xPosition, yPosition)
            firstButton.x += 20;  // Move to the right by 20 pixels
            firstButton.y += 10;  // Move down by 10 pixels
        }
    }

    SquareButton {
        id: secondButton // Unique id for the first instance
        color: "#FF0000" // Override the color property for this instance
        anchors.centerIn: parent // Align the button to the center of the parent (window)

        // Define a JavaScript function to handle the signal
        function handleSignaltest(message) {
            console.log("Second Button Signaltest received with message:", message)
        }

        // Connect the signal to the JavaScript function
        onSignaltest: (message) => handleSignaltest(message)
        // This will print "Deactivated" when the mouse is released.
        onDeactivated: {
            console.log("Second Button Deactivated")
            secondButton.width = 100
        }
        // This will print "Activated at: <xPosition> <yPosition>" when the mouse is pressed.
        onActivated: {
            (xPosition, yPosition) => console.log("Second Button Activated at:", xPosition, yPosition)
            secondButton.width = 200
        }
    }
}
