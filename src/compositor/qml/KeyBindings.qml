/****************************************************************************
 * This file is part of Liri.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini
 *
 * Author(s):
 *    Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
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

import QtQuick 2.5
import QtGSettings 1.0 as Settings

Item {
    /*
     * Key bindings
     */

    Settings.GSettings {
        id: wmKeybindings
        schema.id: "io.liri.desktop.keybindings.wm"
        schema.path: "/io/liri/desktop/keybindings/wm/"
    }

    Settings.GSettings {
        id: smKeybindings
        schema.id: "io.liri.desktop.keybindings.sm"
        schema.path: "/io/liri/desktop/keybindings/sm/"
    }

    Settings.GSettings {
        id: desktopKeybindings
        schema.id: "io.liri.desktop.keybindings.desktop"
        schema.path: "/io/liri/desktop/keybindings/desktop/"
    }

    Settings.GSettings {
        id: mmKeybindings
        schema.id: "io.liri.desktop.keybindings.multimedia"
        schema.path: "/io/liri/desktop/keybindings/multimedia/"
    }

    QtObject {
        id: d

        function switchToWorkspace(number) {
            for (var i = 0; i < liriCompositor.screenManager.count; i++)
                liriCompositor.screenManager.objectAt(i).screenView.layers.workspaces.select(number);
        }
    }

    /*
     * Special shortcuts
     */

    Shortcut {
        property bool showInformation: false

        context: Qt.ApplicationShortcut
        sequence: "Ctrl+Alt+Meta+S"
        onActivated: {
            showInformation = !showInformation;

            for (var i = 0; i < liriCompositor.screenManager.count; i++)
                liriCompositor.screenManager.objectAt(i).screenView.showInformation = showInformation;
        }
    }

    /*
     * Window Manager
     */

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspace1
        onActivated: d.switchToWorkspace(0)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspace2
        onActivated: d.switchToWorkspace(1)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspace3
        onActivated: d.switchToWorkspace(2)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspace4
        onActivated: d.switchToWorkspace(3)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspace5
        onActivated: d.switchToWorkspace(4)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspace6
        onActivated: d.switchToWorkspace(5)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspace7
        onActivated: d.switchToWorkspace(6)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspace8
        onActivated: d.switchToWorkspace(7)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspace9
        onActivated: d.switchToWorkspace(8)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspace10
        onActivated: d.switchToWorkspace(9)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspace11
        onActivated: d.switchToWorkspace(10)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspace12
        onActivated: d.switchToWorkspace(11)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspaceLeft
        onActivated: {
            for (var i = 0; i < liriCompositor.screenManager.count; i++)
                liriCompositor.screenManager.objectAt(i).screenView.layers.workspaces.selectPrevious();
        }
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspaceRight
        onActivated: {
            for (var i = 0; i < liriCompositor.screenManager.count; i++)
                liriCompositor.screenManager.objectAt(i).screenView.layers.workspaces.selectNext();
        }
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspaceUp
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspaceDown
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchToWorkspaceLast
        onActivated: {
            var index = liriCompositor.settings.numWorkspaces - 1;
            for (var i = 0; i < liriCompositor.screenManager.count; i++)
                liriCompositor.screenManager.objectAt(i).screenView.layers.workspaces.select(index);
        }
    }

    /*
    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchWindows
        onActivated: d.switchWindowsForward()
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.switchWindowsBackward
        onActivated: d.switchWindowsBackward()
    }
    */

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.showDesktop
        onActivated: {
            var workspace;
            for (var i = 0; i < liriCompositor.screenManager.count; i++) {
                workspace = liriCompositor.objectAt(i).surfacesArea;
                if (workspace.state === "reveal")
                    workspace.state = "normal";
                else if (workspace.state === "normal")
                    workspace.state = "reveal";
            }
        }
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.presentWindows
        onActivated: {
            var workspace;
            for (var i = 0; i < liriCompositor.screenManager.count; i++) {
                workspace = liriCompositor.objectAt(i).screenView.surfacesArea;
                if (workspace.state === "present")
                    workspace.state = "normal";
                else if (workspace.state === "normal")
                    workspace.state = "present";
            }
        }
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.mainMenu
        onActivated: {
            var panel = liriCompositor.defaultOutput.screenView.desktop.panel
            panel.launcherIndicator.clicked(null)
        }
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.activateWindowMenu
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.toggleFullscreen
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.toggleMaximized
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.toggleAbove
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.maximize
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.unmaximize
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.toggleShaded
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.minimize
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.close
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.beginMove
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.beginResize
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.toggleOnAllWorkspaces
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspace1
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspace2
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspace3
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspace4
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspace5
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspace5
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspace6
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspace7
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspace8
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspace9
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspace10
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspace11
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspace12
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspaceLast
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspaceLeft
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspaceRight
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspaceUp
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToWorkspaceDown
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToMonitorLeft
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToMonitorRight
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToMonitorUp
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToMonitorDown
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.raiseOrLower
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.raise
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.lower
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.maximizeVertically
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.maximizeHorizontally
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToCornerNw
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToCornerNe
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToCornerSw
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToCornerSe
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToSideN
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToSideS
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToSideE
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToSideW
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.moveToCenter
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: wmKeybindings.alwaysOnTop
    }

    /*
     * Session Manager
     */

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: smKeybindings.abortSession
        onActivated: SessionInterface.logOut()
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: smKeybindings.powerOff
        onActivated: SessionInterface.requestPowerOff()
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: smKeybindings.lockScreen
        onActivated: SessionInterface.lockSession()
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: smKeybindings.activateSession1
        onActivated: SessionInterface.activateSession(1)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: smKeybindings.activateSession2
        onActivated: SessionInterface.activateSession(2)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: smKeybindings.activateSession3
        onActivated: SessionInterface.activateSession(3)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: smKeybindings.activateSession4
        onActivated: SessionInterface.activateSession(4)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: smKeybindings.activateSession5
        onActivated: SessionInterface.activateSession(5)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: smKeybindings.activateSession6
        onActivated: SessionInterface.activateSession(6)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: smKeybindings.activateSession7
        onActivated: SessionInterface.activateSession(7)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: smKeybindings.activateSession8
        onActivated: SessionInterface.activateSession(8)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: smKeybindings.activateSession9
        onActivated: SessionInterface.activateSession(9)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: smKeybindings.activateSession10
        onActivated: SessionInterface.activateSession(10)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: smKeybindings.activateSession11
        onActivated: SessionInterface.activateSession(11)
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: smKeybindings.activateSession12
        onActivated: SessionInterface.activateSession(12)
    }

    /*
     * Desktop
     */

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: desktopKeybindings.runCommand
        onActivated: liriCompositor.defaultOutput.screenView.runCommand.open()
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: desktopKeybindings.screenshot
        onActivated: processRunner.launchApplication("io.liri.Screenshot")
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: desktopKeybindings.activeWindowScreenshot
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: desktopKeybindings.windowScreenshot
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: desktopKeybindings.areaScreenshot
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: desktopKeybindings.screenshotClip
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: desktopKeybindings.activeWindowScreenshotClip
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: desktopKeybindings.windowScreenshotClip
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: desktopKeybindings.areaScreenshotClip
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: desktopKeybindings.screencast
    }

    /*
     * Multimedia
     */

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: mmKeybindings.volumeMute
        onActivated: volumeControl.toggleMute()
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: mmKeybindings.volumeUp
        onActivated: volumeControl.increase()
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: mmKeybindings.volumeDown
        onActivated: volumeControl.decrease()
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: mmKeybindings.mediaPlay
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: mmKeybindings.mediaPrevious
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequence: mmKeybindings.mediaNext
    }
}
