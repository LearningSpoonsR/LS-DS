# Modify components of a theme  

## Description  

Themes are a powerful way to customize the non-data components of your plots: 
i.e. titles, labels, fonts, background, gridlines, and legends. 
Themes can be used to give plots a consistent customized look. 
Modify a single plot's theme using `theme()`; 
see `theme_update()` if you want modify the active theme, 
to affect all subsequent plots. 
Theme elements are documented together according to inheritance, read more about theme inheritance below.  

## `axis.title`  

|`axis.title` |   |  
|---|---|  
| axis.title, axis.title.x, axis.title.y, axis.title.x.top, axis.title.x.bottom, axis.title.y.left, axis.title.y.right	|	labels of axes (element_text()). Specify all axes' labels (axis.title), labels by plane (using axis.title.x or axis.title.y), or individually for each axis (using axis.title.x.bottom, axis.title.x.top,axis.title.y.left, axis.title.y.right). axis.title.*.* inherits from axis.title.* which inherits from axis.title, which in turn inherits fromtext |  
