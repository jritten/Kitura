/*
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import SSLService

// MARK: SSLConfig
/// SSLConfig
public struct SSLConfig {

    // MARK: Properties
    /// Config required to configure the `SSLService`
    public private(set) var config: SSLService.Configuration

    // MARK: Lifecycle

    #if os(Linux)
    //MARK: Linux
    /// Initialize an SSLService.Configuration instance using a `CA Certificate` file.
    ///
    /// - Parameter caCertificateFilePath: Path to the PEM formatted CA certificate file.
    /// - Parameter certificateFilePath: Path to the PEM formatted certificate file.
    /// - Parameter keyFilePath: Path to the PEM formatted key file. If nil, `certificateFilePath` will be used.
    /// - Parameter selfSigned:	True if certs are `self-signed`, false otherwise. Defaults to true.
    ///	- Returns:	New SSLConfig instance.
    public init(withCACertificateFilePath caCertificateFilePath: String?, usingCertificateFile certificateFilePath: String?, withKeyFile keyFilePath: String? = nil, usingSelfSignedCerts selfSigned: Bool = true, cipherSuite: String? = nil) {

        config = SSLService.Configuration(withCACertificateFilePath: caCertificateFilePath, usingCertificateFile: certificateFilePath, withKeyFile:keyFilePath, usingSelfSignedCerts: selfSigned, cipherSuite: cipherSuite)
    }

    /// Initialize an SSLService.Configuration instance using a `CA Certificate` directory.
    ///
    ///	*Note:* `caCertificateDirPath` - All certificates in the specified directory **must** be hashed using the `OpenSSL Certificate Tool`.
    ///
    /// - Parameter caCertificateDirPath: Path to a directory containing CA certificates. *(see note above)*
    /// - Parameter certificateFilePath: Path to the PEM formatted certificate file. If nil, `certificateFilePath` will be used.
    /// - Parameter keyFilePath: Path to the PEM formatted key file (optional). If nil, `certificateFilePath` is used.
    /// - Parameter selfSigned:	True if certs are `self-signed`, false otherwise. Defaults to true.
    ///	- Returns: New SSLConfig instance.
    public init(withCACertificateDirectory caCertificateDirPath: String?, usingCertificateFile certificateFilePath: String?, withKeyFile keyFilePath: String? = nil, usingSelfSignedCerts selfSigned: Bool = true, cipherSuite: String? = nil) {

        config = SSLService.Configuration(withCACertificateDirectory:caCertificateDirPath, usingCertificateFile: certificateFilePath, withKeyFile: keyFilePath, usingSelfSignedCerts: selfSigned, cipherSuite: cipherSuite)
    }
    #endif // os(Linux)
    //MARK: MacOS
    /// Initialize an SSLService.Configuration instance using a `Certificate Chain File`.
    ///
    /// *Note:* If using a certificate chain file, the certificates must be in PEM format and must be sorted starting with the subject's certificate (actual client or server certificate), followed by intermediate CA certificates if applicable, and ending at the highest level (root) CA.
    ///
    /// - Parameter chainFilePath: Path to the certificate chain file (optional). *(see note above)*
    /// - Parameter password: Export password for the chain file (optional). This is required if using a certificate chain file.
    /// - Parameter selfSigned:	True if certs are `self-signed`, false otherwise. Defaults to true.
    ///	- Returns:	New SSLConfig instance.
    public init(withChainFilePath chainFilePath: String? = nil, withPassword password: String? = nil, usingSelfSignedCerts selfSigned: Bool = true, cipherSuite: String? = nil) {

        config = SSLService.Configuration(withChainFilePath: chainFilePath, withPassword: password, usingSelfSignedCerts: selfSigned, cipherSuite: cipherSuite)
    }
}
