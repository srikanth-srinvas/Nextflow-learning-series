process helloworld {
"""
#!/usr/bin/env python3

x=1
y=7

print(x+y)
"""
}

workflow {
helloworld()

}