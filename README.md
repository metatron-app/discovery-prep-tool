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


## 1. Get auth token
```
(POST) /oauth/token?grant_type=password&username=admin&password=admin
```
#### Request body
| Name         | Type   | Required | Description | Note |
|:-------------|:-------|:---------|:------------|:-----|
| access_token | string | o        |             |      |


## 2. Get upload policy
```
(GET) /api/preparationdatasets/file_upload
```
#### Response body
| Name       | Type   | Description        | Note                                |
|:-----------|:-------|:-------------------|:------------------------------------|
| upload_id  | string | Pre-generated UUID | Submit upload request with this ID. |
| limit_size | string | Maximum chunk size | >= 350M                             |


## 3. Upload file chunks
```
(POST) /api/preparationdatasets/file_upload
```
#### Request body
| Name         | Type   | Required | Description                | Note |
|:-------------|:-------|:---------|:---------------------------|:-----|
| name         | string | o        | File basename              |      |
| chunk        | int    | o        | Current chunk index        |      |
| chunks       | int    | o        | Total chunk count          |      |
| storage_type | string | o        | Where the file goes        |      |
| chunk_size   | int    | o        | Chunk size of this request |      |
| total_size   | int    | o        | Total upload size in bytes |      |

