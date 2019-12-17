# discovery-prep-tool
A command line program for data preparation. Useful for scripting, scheduling, etc.


## Table of APIs
| No | Action                  | URL                                                | Method    | Content-Type        |
|---:|:------------------------|:---------------------------------------------------|:----------|:--------------------|
|  1 | Get auth token          | /oauth/token                                       | POST      | application/json    |
|  2 | Get upload policy       | /api/preparationdatasets/file_upload               | GET       | application/json    |
|  3 | Upload file chunks      | /api/preparationdatasets/file_upload               | POST      | multipart/form-data |
|  4 | Search data connection  | /api/connections/filter                            | POST      | application/json    |
|  5 | Create imported dataset | /api/preparationdatasets                           | POST      | application/json    |
|  6 | Search dataset          | /api/preparationdatasets/search                    | GET       | application/json    |
|  7 | Get dataset details     | /api/preparationdatasets/{dsId}                    | GET       | application/json    |
|  8 | Get upstream map        | /api/preparationdataflows/{dfId}/upstreammap       | GET       | application/json    |
|  9 | Swap upstream dataset   | /api/preparationdataflows/{dfId}/swap_upstream     | POST      | application/json    |
| 10 | Generate snapshot       | /api/preparationdatasets/{dsId}/transform/snapshot | POST      | application/json    |
| 11 | Get snapshot details    | /api/preparationsnapshots/{ssId}                   | GET       | application/json    |
| 12 | Download snapshot       | /api/preparationsnapshots/{ssId}/download          | GET       | application/json    |
| 13 | Search datasource       | /api/datasources/filter                            | POST      | application/json    |
| 14 | Append to datasource    | /api/datasources/{id}/append                       | PUT/PATCH | application/json    |
| 15 | Create dataflow         | /api/preparationdataflows                          | POST      | application/json    |
| 16 | Add dataset to dataflow | /api/preparationdataflows/{dfId}/update_datasets   | PUT       | application/json    |


## 1. Get auth token
```
(POST) /oauth/token?grant_type=password&username=admin&password=admin
```
#### Request body
| Name         | Type   | Required | Description | Example |
|:-------------|:-------|:---------|:------------|:--------|
| access_token | string | o        |             |         |


## 2. Get upload policy
```
(GET) /api/preparationdatasets/file_upload
```
#### Response body
| Name       | Type   | Description        | Note                                |
|:-----------|:-------|:-------------------|:------------------------------------|
| upload_id  | string | Pre-generated UUID | Submit upload request with this ID. |
| limit_size | int    | Maximum chunk size | >= 350M                             |


## 3. Upload file chunks
```
(POST) /api/preparationdatasets/file_upload
```
#### Request parameters
| Name         | Type   | Required | Description                | Example    |
|:-------------|:-------|:---------|:---------------------------|:-----------|
| name         | string | o        | File basename              | sample.csv |
| chunk        | int    | o        | Current chunk index        | 0          |
| chunks       | int    | o        | Total chunk count          | 1          |
| storage_type | string | o        | LOCAL / HDFS / S3          | LOCAL      |
| chunk_size   | int    | o        | Chunk size of this request | 135678     |
| total_size   | int    | o        | Total upload size in bytes | 135678     |

#### Response body
| Name      | Type   | Description                       | Note                                                                              |
|:----------|:-------|:----------------------------------|:----------------------------------------------------------------------------------|
| storedUri | string | Where the uploaded file is stored | There's nothing like a file key. This is the only identifier for an uploaded file. |


## 4. Search data connection
```
(POST) /api/connections/filter
```
#### Request parameters
| Name       | Type   | Required | Description | Example          |
|:-----------|:-------|:---------|:------------|:-----------------|
| projection | string | o        | Projection  | list             |
| page       | int    | o        | Page number | 0                |
| size       | int    | o        | Page size   | 20               |
| sort       | string |          | Sort order  | createdTime,desc |

#### Request body
| Name         | Type   | Required | Description    | Example |
|:-------------|:-------|:---------|:---------------|:--------|
| containsText | string | o        | Text to search | ostgre  |

#### Response body
| Name | Type   | Description           | Note                        |
|:-----|:-------|:----------------------|:----------------------------|
| id   | string | Databse connection ID | In `_embedded[connections]` |


## 5. Create imported dataset
```
(POST) /api/preparationdatasets
```
#### Request body
| Name                 | Type   | Required     | Description                            | Example                              | Note                  |
|:---------------------|:-------|:-------------|:---------------------------------------|:-------------------------------------|:----------------------|
| dsName               | string | o            | Dataset name                           | sales dataset                        |                       |
| dsDesc               | string |              | Dataset description                    |                                      |                       |
| dsType               | string | o            | Dataset type                           | IMPORTED                             |                       |
| importType           | string | o            | UPLOAD / URL / DATABASE / ...          | DATABASE                             |                       |
| delimiter            | string | o (file)     | Column delimiter                       | ,                                    | File dataset only     |
| quoteChar            | string | o (file)     | Quote character for delimiters         | "                                    | File dataset only     |
| filenameBeforeUpload | string | o (file)     | Filename before upload for information | sample.csv                           | File dataset only     |
| storageType          | string | o (file)     | LOCAL / HDFS / S3                      | LOCAL                                | File dataset only     |
| sheetName            | string | o (file)     | Sheet name when EXCEL                  | sheet1                               | File dataset only     |
| fileFormat           | string | o (file)     | CSV / JSON / EXCEL                     | CSV                                  | File dataset only     |
| manualColcnt         | int    |              | Manually set the column count          | 100                                  | File dataset only     |
| dcId                 | string | o (database) | Data connection ID                     | d6647451-9b92-47cb-9214-91c2a024e202 | Database dataset only |
| rsType               | string | o (database) | Result set type - TABLE / QUERY        | QUERY                                | Database dataset only |
| queryStmt            | string | o (database) | SQL statement without ;                | SELECT * FROM EMP                    | Database dataset only |

#### Response body
| Name | Type   | Description         | Note |
|:-----|:-------|:--------------------|:-----|
| dsId | string | Imported dataset ID |      |



