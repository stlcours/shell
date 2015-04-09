/****************************************************************************
 * This file is part of Hawaii.
 *
 * Copyright (C) 2015 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * Author(s):
 *    Pier Luigi Fiorini
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

#include <QtCore/QDataStream>
#include <QtNetwork/QLocalServer>
#include <QtNetwork/QLocalSocket>

#include "messages.h"
#include "socketserver.h"

Q_LOGGING_CATEGORY(SOCKETSERVER, "hawaii.session.socket")

using namespace Hawaii;

SocketServer::SocketServer(QObject *parent)
    : QObject(parent)
    , m_server(Q_NULLPTR)
{
}

SocketServer::~SocketServer()
{
}

QString SocketServer::address() const
{
    if (m_server)
        return m_server->fullServerName();
    return QString();
}

bool SocketServer::start(const QString &socketName)
{
    // Do not start twice
    if (m_server)
        return true;

    m_server = new QLocalServer(this);
    m_server->setSocketOptions(QLocalServer::UserAccessOption);
    if (m_server->listen(socketName)) {
        qCDebug(SOCKETSERVER) << "Listening on" << socketName;
        connect(m_server, &QLocalServer::newConnection,
                this, &SocketServer::newConnection);
    } else {
        qCWarning(SOCKETSERVER) << "Failed to listen on" << socketName;
        return false;
    }

    return true;
}

void SocketServer::stop()
{
    if (!m_server)
        return;

    qCDebug(SOCKETSERVER) << "Stopping server...";

    m_server->deleteLater();
    m_server = Q_NULLPTR;

    qCDebug(SOCKETSERVER) << "Server stopped";
}

void SocketServer::newConnection()
{
    QLocalSocket *socket = m_server->nextPendingConnection();
    connect(socket, &QLocalSocket::readyRead,
            this, &SocketServer::readyRead);
    connect(socket, &QLocalSocket::disconnected,
            socket, &QLocalSocket::deleteLater);
}

void SocketServer::readyRead()
{
    QLocalSocket *socket = qobject_cast<QLocalSocket *>(sender());
    if (!socket)
        return;

    QDataStream input(socket);

    // Read message type
    quint32 type;
    input >> type;

    // Read messages
    switch (CompositorMessages(type)) {
    case CompositorMessages::Connected:
        qCDebug(SOCKETSERVER) << "Compositor connection established";
        Q_EMIT connected();
        break;
    case CompositorMessages::SetIdle: {
        bool value;
        input >> value;
        qCDebug(SOCKETSERVER) << "SetIdle:" << value;
        Q_EMIT idleChanged(value);
        break;
    }
    default:
        break;
    }
}

#include "moc_socketserver.cpp"