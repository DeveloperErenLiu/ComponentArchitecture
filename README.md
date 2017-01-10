> 这段时间好多同学说虽然提供了`Demo`，但还是不太清楚组件化架构的集成方式，包括怎么创建私有仓库和配置`Spec`之类的。正好这段时间不是太忙了，我在这里简单的写一下架构集成方面的东西。

***

### 创建私有仓库

##### 创建私有代码仓库

首先创建一个托管当前组件的私有代码仓库，然后将仓库`Clone`下来，把模块代码`Push`上去。例如下面的地址：

https://git.coding.net/LiuXiaoZhuang/HomePageModule.git

这样就完成一个雏形了，可以通过这个代码仓库进行组件的代码管理了，这一块和平时的代码版本控制操作一样，所以就不详细讲了。

##### 创建私有Spec仓库

现在要创建私有的`Spec`仓库了。这时候你肯定有疑问了，不是已经有私有仓库了吗，这是干啥的？

很多人都在这块犯错了，所以这里要着重讲一下。就像`CocoaPods`的开源仓库一样，平时用来开发的代码和发布给别人使用的代码，是不在同一个仓库的。

例如`AFNetworking`，代码仓库是在[AFNetworking代码仓库](https://github.com/AFNetworking/AFNetworking.git)这里，而`AFNetworking`提供给其他人使用的时候，需要先提交到`CocoaPods`的`Spec`仓库，然后我们从`Pod Install`都是从`Spec`仓库拉去下来的代码。这么说大家理解了吧，不理解就去我博客里留言吧。

例如我们创建的`Spec`仓库是下面的地址，最后提供给其他人的代码都要被提交到这里。创建`Spec`代码仓库和平时创建一样，只是这里暂时先为空，也不需要进行`Clone`操作。

https://git.coding.net/LiuXiaoZhuang/HomePageModuleSpec.git

### 搭建环境

##### 创建.podspec文件

找到私有仓库`HomePageModule`所在的目录，在这个目录下通过下面命令，创建一个新的`.podspec`文件，在这个文件中来进行私有仓库的一些配置工作。

```
pod spec create HomePageModule
```

创建这个文件后，需要修改里面的一些东西，例如这里我用`HomePageModule`私有仓库做例子。这里面修改的东西，表示你的`Spec`私有仓库的一些特征，例如`name`、`source`、`version`之类的，在进行`pod search`操作时候的显示结果，也是由这个文件决定的。

需要注意的是，下面的`source`设置为`HomePageModule`仓库而不是`Spec`仓库，这一步很多人都在这里犯错。

	Pod::Spec.new do |s|
		s.name          = "HomePageModule"
		s.version       = "1.0"
		s.summary       = "description of HomePageModule"
		s.description   = <<-DESC
			"this is HomePageModule content description."
	              DESC
		s.homepage      = "https://coding.net/u/LiuXiaoZhuang/p/HomePageModule/git"
		s.license       = "MIT"
		s.author        = { "LiuXiaoZhuang" => "2046703959@qq.com" }
		s.source        = { :git => "https://git.coding.net/LiuXiaoZhuang/HomePageModule.git", :tag => "#{s.version}" }
		s.exclude_files = "HomePageModule/HomePageModule/AppDelegate.{h,m}", "HomePageModule/HomePageModule/main.m"
		s.source_files  = "HomePageModule/HomePageModule/*.{h,m}"
		s.frameworks    = 'UIKit'
		s.platform      = :ios
	end

### 开发过程

##### 验证podspec文件

先用`pod`命令验证一下这个`.podspec`文件有没有问题。

```
pod lib lint
```

如果没问题会提示

```
HomePageModule passed validation.
```

如果没问题就将`HomePageModule`的代码提交到私有服务器上，连同生成的`.podspec`文件也要一块提交上去。

##### 关联podspec到Spec私有仓库

通过下面命令，添加远程`Spec`仓库到本地，相当于建立一个连接关系。(需要注意这里的地址是`Spec`的地址，不要写错)

```
pod repo add HomePageModule https://git.coding.net/LiuXiaoZhuang/HomePageModuleSpec.git
```

添加完成后，用下面命令检查一下是否成功。

```
pod repo lint
```

##### 提交代码到Spec私有仓库

如果上面命令没问题后，这就代表组件的私有仓库和其对应的`Spec`仓库，已经可以提交并向外提供代码了。这时候我们就可以进行代码开发，开发完成之后通过下面的命令，将代码提交或更新到`Spec`仓库。

```
pod repo push HomePageModule HomePageModule.podspec
```

提交给`Spec`私有仓库的文件，可以通过`.podspec`文件的`s.source_files`字段进行过滤，符合过滤条件的文件就都会被提交到`Spec`仓库。例如上面我们将所有`.h`和`.m`文件都提交到`Spec`仓库，除了这些还可以设置`imageAssets`、`XIB`、`Bundle`等文件。

### 使用私有仓库代码

当`Spec`私有仓库中有可用的代码后，就可以通过`CocoaPods`命令来使用组件代码了。在`Podfile`文件中需要声明私有仓库地址，例如下面代码。

	source 'https://git.coding.net/LiuXiaoZhuang/HomePageModuleSpec.git'
	
	target 'MainProject' do
	    # 第三方库
	    pod 'Masonry'
	    pod 'MGJRouter'
	
	    # 私有仓库
	    pod 'HomePageModule',   '~> 1.1'
	end
在配置好这套环境后，之后的开发就只需要执行上面`pod repo push`的操作了。根据业务需求发布指定的组件版本，并将组件`push`到`Spec`私有仓库供其他人使用即可。

版本控制也非常简单，只需要在`Podfile`中指定某个私有仓库的版本号即可。









