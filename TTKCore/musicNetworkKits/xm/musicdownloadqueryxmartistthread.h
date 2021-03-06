#ifndef MUSICDOWNLOADQUERYXMARTISTTHREAD_H
#define MUSICDOWNLOADQUERYXMARTISTTHREAD_H

/* =================================================
 * This file is part of the TTK Music Player project
 * Copyright (c) 2015 - 2017 Greedysky Studio
 * All rights reserved!
 * Redistribution and use of the source code or any derivative
 * works are strictly forbiden.
   =================================================*/

#include "musicdownloadxminterface.h"
#include "musicdownloadquerythreadabstract.h"

/*! @brief The class to xiami query artist download data from net.
 * @author Greedysky <greedysky@163.com>
 */
class MUSIC_NETWORK_EXPORT MusicDownLoadQueryXMArtistThread : public MusicDownLoadQueryThreadAbstract,
                                                              private MusicDownLoadXMInterface
{
    Q_OBJECT
public:
    explicit MusicDownLoadQueryXMArtistThread(QObject *parent = 0);
    /*!
     * Object contsructor.
     */

    static QString getClassName();
    /*!
     * Get class object name.
     */

    virtual void startSearchSong(QueryType type, const QString &artist) override;
    /*!
     * Start to Search data from name and type.
     */
    void startSearchSong(const QString &artist);
    /*!
     * Start to Search data from name and type.
     */
    void startLostArtist();
    /*!
     * Start to Search lost artist.
     */

public Q_SLOTS:
    virtual void downLoadFinished() override;
    /*!
     * Download data from net finished.
     */
    void songListFinished();
    /*!
     * Query song list finished.
     */

protected:
    void startSongListQuery();
    /*!
     * Start to search song list by id.
     */

    QSet<QString> m_songIds;
    int m_index;

};

#endif // MUSICDOWNLOADQUERYXMARTISTTHREAD_H
