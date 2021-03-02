/*
 * Copyright (C) 2011 The Android Open Source Project
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

package com.android.volley;

import android.net.TrafficStats;
import android.net.Uri;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;

import com.android.volley.VolleyLog.MarkerLog;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Collections;
import java.util.Map;

/**
 * Base class for all network requests.
 *
 * @param <T> The type of parsed response this request expects.
 */
public abstract class Request<T> implements Comparable<Request<T>> {

    /**
     * Default encoding for POST or PUT parameters. See {@link #getParamsEncoding()}.
     */
    private static final String DEFAULT_PARAMS_ENCODING = "UTF-8";

    /**
     * Supported request methods.
     */
    public interface Method {
        int DEPRECATED_GET_OR_POST = -1;
        int GET = 0;
        int POST = 1;
        int PUT = 2;
        int DELETE = 3;
        int HEAD = 4;
        int OPTIONS = 5;
        int TRACE = 6;
        int PATCH = 7;
    }

    /**
     * Callback to notify when the network request returns.
     */
    /* package */ interface NetworkRequestCompleteListener {

        /** Callback when a network response has been received. */
        void onResponseReceived(Request<?> request, Response<?> response);

        /** Callback when request returns from network without valid response. */
        void onNoUsableResponseReceived(Request<?> request);
    }

    /** An event log tracing the lifetime of this request; for debugging. */
    private final MarkerLog mEventLog = MarkerLog.ENABLED ? new MarkerLog() : null;

    /**
     * Request method of this