<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 	<form action="./${root}${function}" method="post" enctype="multipart/form-data" id="frm">
		<div class="form-group">
			<label for="title">Title:</label>
			<input type="text" class="form-control" value="${vo.title}" id="title" placeholder="Enter title" name="title">
		</div>
		<div class="form-group">
			<label for="writer">Writer:</label>
			<input type="text" class="form-control" value="${vo.writer}" id="writer" placeholder="Enter writer" name="writer">
		</div>
		<div class="form-group">
			<label for="contents">Contents:</label>
			<textarea class="form-control" rows="5" id="contents" name="contents">${vo.contents}</textarea>
		</div>
		<div class="form-group">
			<label for="file">File:</label>
			<input type="file" class="form-control" name="files">
			<input type="file" class="form-control" name="files">
			<div>
				<table id="file-list">
					<c:forEach items="${vo.fileVOs}" var="file">
						<tr>
							<td id="file-name">${file.oriName}</td>
							<td style="text-align: right;"><input type="button" id="file-delete" title="${file.FNum}" value="x"></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<button type="submit" id="write-btn" class="btn btn-default">${function}</button>
  	</form>