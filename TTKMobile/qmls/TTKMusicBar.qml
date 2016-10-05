import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

import "Core"

Rectangle {
    id: ttkMusicBar
    anchors.right: ttkMainWindow.right
    anchors.bottom: ttkMainWindow.bottom
    width: ttkMainWindow.width
    height: dpHeight(70)
    border {
        color: ttkTheme.alphaLv9
        width: 1
    }
    color: ttkTheme.white
    Component.onCompleted: {
        musicNameTitle.text = TTK_APP.empty() ? "天天酷音" : TTK_APP.mediaName();
        musicArtistTitle.text = TTK_APP.empty() ? "天天酷音" : TTK_APP.mediaArtist();
    }

    function playStateChanged() {
        if(TTK_PLAYER.state() === 1) {
            barPlayButton.source = "qrc:/image/landscape_player_btn_pause_normal";
            musicBarImageAnimation.resume();
            musicBarImageAnimation.start();
        }else{
            barPlayButton.source = "qrc:/image/landscape_player_btn_play_normal";
            musicBarImageAnimation.pause();
        }
    }

    Connections {
        target: TTK_APP
        onCurrentIndexChanged: {
            musicNameTitle.text = TTK_APP.mediaName();
            musicArtistTitle.text = TTK_APP.mediaArtist();
            playStateChanged();
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            if(!TTK_APP.empty()) {
                ttkOutStackView.push("qrc:/qmls/TTKMusicPlayerCenterPage.qml");
            }
        }
    }

    TTKRadiusImage {
        id: musicBarImage
        width: parent.height
        height: parent.height
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: dpHeight(10)
        }
        color: ttkTheme.alphaLv0
        foreground: "qrc:/image/landscape_check_album_normal"
        background: "qrc:/image/radius_mask"

        RotationAnimation {
            id: musicBarImageAnimation
            target: musicBarImage
            property: "rotation"
            from: 0
            to: 360
            direction: RotationAnimation.Clockwise
            duration: 4000
            loops: Animation.Infinite
        }
    }

    Text {
        id: musicNameTitle
        width: ttkMusicBar.width - barPlayButton.width - barPlayListButton.width - musicBarImage.width - dpHeight(30)
        anchors {
            left: musicBarImage.right
            top: parent.top
            leftMargin: dpHeight(5)
            topMargin: dpHeight(10)
        }
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        font.pixelSize: parent.height/4
        text: "天天酷音"
    }

    Text {
        id: musicArtistTitle
        width: musicNameTitle.width
        anchors {
            left: musicBarImage.right
            top: musicNameTitle.bottom
            leftMargin: dpHeight(5)
            topMargin: dpHeight(10)
        }
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        color: "gray"
        text: "天天酷音"
    }

    TTKImageButton {
        id: barPlayListButton
        source: "qrc:/image/minibar_btn_playlist_normal"
        anchors {
            right: parent.right
            top: parent.top
            topMargin: (parent.height - height)/2
            rightMargin: dpHeight(10)
        }
        width: height
        height: dpHeight(60)
    }

    TTKImageButton {
        id: barPlayButton
        source: "qrc:/image/landscape_player_btn_play_normal"
        anchors {
            right: barPlayListButton.left
            top: parent.top
            topMargin: (parent.height - height)/2
            rightMargin: dpHeight(10)
        }
        width: height*1.2
        height: dpHeight(50)
        onPressed: {
            if(TTK_APP.empty()) {
                return;
            }
            if(TTK_PLAYER.state() === 1) {
                barPlayButton.source = "qrc:/image/landscape_player_btn_play_normal";
                TTK_PLAYER.pause();
                musicBarImageAnimation.pause();
            }else{
                barPlayButton.source = "qrc:/image/landscape_player_btn_pause_normal";
                TTK_PLAYER.play();
                musicBarImageAnimation.resume();
                musicBarImageAnimation.start();
            }
        }
    }
}
