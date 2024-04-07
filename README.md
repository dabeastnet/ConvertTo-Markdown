# ConvertTo-Markdown

## Overview
The `ConvertTo-Markdown` PowerShell function is designed to help automate the conversion of arrays, hashtables, and PSCustomObjects into Markdown format. This tool is particularly useful for generating documentation, reports, or any content where structured data needs to be presented in a readable Markdown format.

## Features
- **Array to List Conversion:** Converts an array of elements into a Markdown formatted list.
- **Hashtable and PSCustomObject to Table Conversion:** Converts hashtables and PSCustomObjects into Markdown tables, making structured data readable and easy to understand.

## Prerequisites
- PowerShell 5.1 or higher

## Installation
This function does not require installation. You can simply copy the `ConvertTo-Markdown` function code into your PowerShell script or session.

## Usage

### Converting an Array to a Markdown List
```powershell
$array = 1..5
$array | ConvertTo-Markdown
```
Output:
```
- 1
- 2
- 3
- 4
- 5
```

### Converting a Hashtable to a Markdown Table
```powershell
$hashtable = @{Name='John Doe'; Age=30; Department='IT'}
$hashtable | ConvertTo-Markdown
```
Output:
```
| Name     | Age | Department |
|----------|-----|------------|
| John Doe | 30  | IT         |
```

### Converting a PSCustomObject to a Markdown Table
```powershell
$object = [PSCustomObject]@{Name='Jane Doe'; Age=29; Department='HR'}
$object | ConvertTo-Markdown
```
Output:
```
| Name     | Age | Department |
|----------|-----|------------|
| Jane Doe | 29  | HR         |
```

## Contributing
Contributions to improve `ConvertTo-Markdown` are welcome. Please feel free to fork the repository, make changes, and submit pull requests.

## License
GNU General Public License v3.0

