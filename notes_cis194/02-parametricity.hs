limited :: a -> a

limited x = x

main = do
    print (limited 5)
    print (limited 'a')
    print (limited "hello")
