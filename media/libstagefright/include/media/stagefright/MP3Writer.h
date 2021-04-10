/*
 * Copyright (C) 2010 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef MP3_WRITER_H_

#define MP3_WRITER_H_

#include <stdio.h>

//#include <media/IMediaSource.h>
#include "foundation/ABase.h"
#include <media/stagefright/MediaWriter.h>
#include <utils/threads.h>

namespace android {

class MetaData;

struct MP3Writer : public MediaWriter {
    MP3Writer(int fd);

    status_t initCheck() const;

    virtual status_t addSource(const sp<MediaSource> &source);
    virtual bool reachedEOS();
    virtual status_t start(MetaData *params = NULL);
    virtual status_t stop() { return reset(); }
    virtual status_t pause();

protected:
    virtual ~MP3Writer();

private:
    int   mFd;
    status_t mInitCheck;
    sp<MediaSource> mSource;
    bool mStarted;
    volatile bool mPaused;
    volatile bool mResumed;
    volatile bool mDone;
    volatile bool mReachedEOS;
    pthread_t mThread;
    int64_t mEstimatedSizeBytes;
    int64_t mEstimatedDurationUs;

    static void *ThreadWrapper(void *);
    status_t threadFunc();
    bool exceedsFileSizeLimit();
    bool exceedsFileDurationLimit();
    status_t reset();

    MP3Writer(const MP3Writer &);
    MP3Writer &operator=(const MP3Writer &);
};

}  // namespace android

#endif  // MP3_WRITER_H_

