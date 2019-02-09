# Modify components of a theme  

## Description  

Themes are a powerful way to customize the non-data components of your plots: 
i.e. titles, labels, fonts, background, gridlines, and legends. 
Themes can be used to give plots a consistent customized look. 
Modify a single plot's theme using `theme()`; 
see `theme_update()` if you want modify the active theme, 
to affect all subsequent plots. 
Theme elements are documented together according to inheritance, read more about theme inheritance below.  

## Arguments  

|Category | Argument | Description |    
|---|---|---|   
| `axis.title` | axis.title, axis.title.x, axis.title.y, axis.title.x.top, axis.title.x.bottom, axis.title.y.left, axis.title.y.right	|	labels of axes (element_text()). Specify all axes' labels (axis.title), labels by plane (using axis.title.x or axis.title.y), or individually for each axis (using axis.title.x.bottom, axis.title.x.top,axis.title.y.left, axis.title.y.right). axis.title.*.* inherits from axis.title.* which inherits from axis.title, which in turn inherits fromtext |     
|`axis.text`|axis.text, axis.text.x, axis.text.y, axis.text.x.top, axis.text.x.bottom, axis.text.y.left, axis.text.y.right | tick labels along axes (element_text()). Specify all axis tick labels (axis.text), tick labels by plane (using axis.text.x or axis.text.y), or individually for each axis (using axis.text.x.bottom, axis.text.x.top,axis.text.y.left, axis.text.y.right). axis.text.*.* inherits fromaxis.text.* which inherits from axis.text, which in turn inherits from text |  
| `axis.ticks` | axis.ticks, axis.ticks.x, axis.ticks.x.top, axis.ticks.x.bottom, axis.ticks.y, axis.ticks.y.left, axis.ticks.y.right |	tick marks along axes (element_line()). Specify all tick marks (axis.ticks), ticks by plane (using axis.ticks.x or axis.ticks.y), or individually for each axis (using axis.ticks.x.bottom, axis.ticks.x.top,axis.ticks.y.left, axis.ticks.y.right). axis.ticks.*.* inherits from axis.ticks.* which inherits from axis.ticks, which in turn inherits fromline
