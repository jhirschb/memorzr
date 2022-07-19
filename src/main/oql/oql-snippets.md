## Simple OQL queries for use in JVisualVM

Query Java heap dumps in JVisualVm
find an old version of the docs [here](https://htmlpreview.github.io/?https://raw.githubusercontent.com/visualvm/visualvm.java.net.backup/master/www/docindex.html)

### Filter HashMaps
Shows navigation in java objects and simple filtering
<pre><code>
select f.table[0].key.toString()
from java.util.HashMap f
where f.size > 0 
    && f.table[0] != null 
    && !/Dump/.test(f.table[0].key.toString())
</code></pre>

### Filter Root objects
Better code structure with a separate js function 
<pre><code>
select filter(heap.roots(), myfilter);

function myfilter(object) {
 return !/sun|javax|java/.test(object.name)
	;
}
</code></pre>
