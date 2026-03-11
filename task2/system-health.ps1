$cpu = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
$mem = Get-WmiObject Win32_OperatingSystem
$memFree = [math]::Round(($mem.FreePhysicalMemory/1MB),2)
$memTotal = [math]::Round(($mem.TotalVisibleMemorySize/1MB),2)
$memUsedPct = [math]::Round((($memTotal - $memFree)/$memTotal)*100,2)
$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
$diskFreePct = [math]::Round(($disk.FreeSpace/$disk.Size)*100,2)

Write-Output "CPU: $cpu%"
Write-Output "Memory Used: $memUsedPct%"
Write-Output "Disk Free: $diskFreePct%"

if ($cpu -gt 80 -or $memUsedPct -gt 80 -or $diskFreePct -lt 10) {
    Write-Warning "ALERT: System resource threshold exceeded!"
}
