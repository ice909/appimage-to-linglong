# AppImage to Linglong 转换工具

本项目提供了一组脚本，用于将AppImage应用转换为Linglong格式并管理Linglong仓库中的应用。

## 脚本说明

### check.sh

检查指定的应用版本是否已存在于Linglong仓库中。

**用法**:

```bash
./check.sh <仓库URL> <仓库名称> <应用ID> <版本号>
```

**参数**:

- `<仓库URL>`: Linglong仓库的URL地址
- `<仓库名称>`: Linglong仓库名称
- `<应用ID>`: 应用的唯一标识符（会自动转换为小写）
- `<版本号>`: 应用的版本号

**返回值**:

- `0`: 应用版本不存在，可以继续推送操作
- `1`: 应用版本已存在，应跳过推送操作

### push.sh

将Linglong格式的应用推送到指定的Linglong仓库。

**用法**:

```bash
./push.sh <应用ID> <仓库URL> <仓库名称>
```

**参数**:

- `<应用ID>`: 应用的唯一标识符
- `<仓库URL>`: Linglong仓库的URL地址
- `<仓库名称>`: Linglong仓库名称

**说明**:
脚本会在`<应用ID>`目录下查找`.layer`文件并推送到指定的仓库。

### test.sh

测试Linglong应用是否可以成功运行。

**用法**:

```bash
./test.sh <应用ID>
```

**参数**:

- `<应用ID>`: 应用的唯一标识符

**说明**:
脚本会执行以下操作：

1. 设置默认仓库为dev
2. 安装指定应用
3. 运行应用5秒
4. 检查应用是否成功运行
5. 终止应用进程并卸载应用

**返回值**:

- `0`: 应用测试成功
- 非零: 应用测试失败

## 工作流程示例

1. 首先检查应用是否已存在:

```bash
./check.sh https://linglong-repo.example.com repo-name org.example.app 1.0.0
```

2. 如果应用不存在，推送应用:

```bash
./push.sh org.example.app https://linglong-repo.example.com repo-name
```

3. 测试应用是否可以运行:

```bash
./test.sh org.example.app
```
