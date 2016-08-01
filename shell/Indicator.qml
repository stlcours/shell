/****************************************************************************
 * This file is part of Hawaii.
 *
 * Copyright (C) 2014-2016 Pier Luigi Fiorini
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:GPL2+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0

Item {
    property string name
    property alias iconName: icon.name
    property alias iconSize: icon.width
    property alias text: label.text
    property int badgeCount: 0
    property bool active: false
    property string tooltip
    readonly property bool selected: selectedIndicator == indicator
    readonly property bool expanded: __priv.expanded
    property Component component

    signal triggered(var caller)

    id: indicator
    width: {
        if (!visible)
            return 0;

        var size = 0;
        if (iconName)
            size += icon.width + (Units.smallSpacing * 2);
        if (text)
            size += label.width + (Units.smallSpacing * 2);
        if (iconName && text)
            size += Units.smallSpacing * 2;
        return Math.max(size, Units.smallSpacing * 10);
    }
    height: Math.max(Math.max(icon.height, label.height) + (Units.smallSpacing * 2), Units.smallSpacing * 10)
    onTriggered: __priv.expanded = !__priv.expanded

    QtObject {
        id: __priv

        property bool expanded: false
    }

    Rectangle {
        id: container
        anchors.fill: parent
        anchors.margins: Units.smallSpacing
        color: Material.accentColor
        radius: 6
        opacity: active ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation {
                easing.type: Easing.InOutQuad
                duration: Units.shortDuration
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: indicator.triggered(indicator)
    }

    Icon {
        id: icon
        anchors.centerIn: parent
        color: active ? Material.primaryHighlightedTextColor : Material.primaryTextColor
        height: width
        cache: false
    }

    Label {
        id: label
        anchors.centerIn: parent
        font.pixelSize: Units.roundToIconSize(Units.iconSizes.small)
    }

    Rectangle {
        id: badge
        anchors {
            top: parent.top
            right: parent.right
            topMargin: -(Units.smallSpacing * 0.5)
            rightMargin: -(Units.largeSpacing * 0.5)
        }
        width: Units.iconSizes.smallMedium
        height: width
        radius: width * 0.5
        color: "orangered"
        opacity: indicator.badgeCount > 0 ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation {
                easing.type: Easing.OutQuad
                duration: Units.shortDuration
            }
        }

        Label {
            anchors.centerIn: parent
            font.pixelSize: parent.width - Units.smallSpacing
            color: "white"
            text: indicator.badgeCount
        }
    }
}
