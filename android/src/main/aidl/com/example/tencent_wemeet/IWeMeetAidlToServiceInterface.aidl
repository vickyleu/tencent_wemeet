// IWeMeetAidlToServiceInterface.aidl
package com.example.tencent_wemeet;
import com.example.tencent_wemeet.IWeMeetAidlToMainInterface;

// Declare any non-default types here with import statements
interface IWeMeetAidlToServiceInterface {
    void launchService(in IWeMeetAidlToMainInterface impl,in boolean isPrivacyNeedGrant);

    void notifyPrivacyGranted();

    void destory();
}

