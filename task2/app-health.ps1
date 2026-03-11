

# Bypass self-signed certificate validation using .NET
Add-Type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
        return true;
    }
}
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

# Define URL (Ingress endpoint)
$URL = "https://wisecow.local"

try {
    $response = Invoke-WebRequest -Uri $URL -ErrorAction Stop

    if ($response.StatusCode -eq 200) {
        Write-Output "✅ Application is UP at $URL"
    } else {
        Write-Output "⚠️ Application returned status code $($response.StatusCode)"
    }
}
catch {
    Write-Output "❌ Application is DOWN or not reachable at at $URL"
    Write-Output $_.Exception.Message
}
