<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>plupload示例</title>
<script src="http://cdn.bootcss.com/jquery/1.9.0/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/plupload.full.min.js"></script>

</head>
<body>
	<div id="filelist">
	
	</div>
	<button id="uploader">选择文件</button>
	<div id="progress"></div>
	<div id="result"></div>
</body>
<script type="text/javascript">
		var uploader = new plupload.Uploader({
            runtimes : 'html5,flash,silverlight',//设置运行环境，会按设置的顺序，可以选择的值有html5,gears,flash,silverlight,browserplus,html
			flash_swf_url : './js/Moxie.swf',
			silverlight_xap_url : './js/Moxie.xap',
	        url : '${pageContext.request.contextPath}/uploadFile.do',//上传文件路径
            max_file_size : '3gb',//100b, 10kb, 10mb, 1gb
            chunk_size : '1mb',//分块大小，小于这个大小的不分块
            unique_names : true,//生成唯一文件名
            browse_button : 'uploader', 
            filters : [ {
                title : 'Image files',
                extensions : 'jpg,gif,png'
            }, {
                title : 'Zip files',
                extensions : 'zip,7z,rar'
            } ],
			
            init : {
				FilesAdded: function(up, files) {
				
					uploader.start();
					return false;
				},
                FileUploaded : function(up, file, info) {//文件上传完毕触发
                	console.log("单独文件上传完毕");
                    var response = $.parseJSON(info.response);
                    if (response.status) {
                        $('#result').append( $('<div> "文件路径是："' + response.fileUrl + '"随机的文件名字为："' + file.name + '</div>') );
                    }
                },
                UploadComplete : function( uploader,files ) {
                	console.log("所有文件上传完毕");
                },
                UploadProgress : function( uploader,file ) {
                	$("#progress").html("上传进度为：" + file.percent + "%");
                	console.log( file.percent );
                }
            }
        });
        
		uploader.init();
</script>
</html>