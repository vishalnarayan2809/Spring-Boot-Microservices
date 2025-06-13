# PowerShell script to update package names and file content
$basePath = "c:\Users\guruk\OneDrive\Desktop\Spring-Boot-Microservices"

# Move the updated files
Move-Item -Path "$basePath\README.md.new" -Destination "$basePath\README.md" -Force
Move-Item -Path "$basePath\product-service\pom.xml.new" -Destination "$basePath\product-service\pom.xml" -Force

# Define services
$services = @(
    "order-service",
    "inventory-service",
    "product-service",
    "discovery-service", 
    "api-gateway",
    "notification-service"
)

# Process each service
foreach ($service in $services) {
    Write-Output "Processing $service..."
    
    # Update pom.xml
    $pomPath = "$basePath\$service\pom.xml"
    if (Test-Path $pomPath) {
        $content = Get-Content $pomPath -Raw
        $updatedContent = $content -replace "com\.programming\.beko", "com.programming.vishal" `
                                  -replace "microservices-parent-updated", "microservices-parent" `
                                  -replace "<n>Archetype - .*?</n>", "<name>Vishal's $($service -replace '-',' ')</name>"
        Set-Content -Path $pomPath -Value $updatedContent
    }
    
    # Find Java files
    $javaFiles = Get-ChildItem -Path "$basePath\$service\src" -Filter "*.java" -Recurse
    foreach ($file in $javaFiles) {
        $content = Get-Content $file.FullName -Raw
        $updatedContent = $content -replace "com\.programmingbeko", "com.programmingvishal"
        Set-Content -Path $file.FullName -Value $updatedContent
    }
    
    # Find application.properties/yml files
    $configFiles = Get-ChildItem -Path "$basePath\$service\src" -Include "application*.properties","application*.yml" -Recurse
    foreach ($file in $configFiles) {
        $content = Get-Content $file.FullName -Raw
        $updatedContent = $content -replace "com\.programmingbeko", "com.programmingvishal"
        Set-Content -Path $file.FullName -Value $updatedContent
    }
}

Write-Output "All services processed. Creating new git repository..."

# Create new git repository
Set-Location $basePath
Remove-Item -Path "$basePath\.git" -Recurse -Force
git init
git add .
git config --global user.email "vishal@example.com"
git config --global user.name "Vishal"
git commit -m "Initial commit of Vishal's Spring Boot Microservices Project"

Write-Output "Repository created. To push to a remote repository, use:"
Write-Output "git remote add origin <your-repo-url>"
Write-Output "git push -u origin master"
