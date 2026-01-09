test TEST:
    @echo "--------------------------------"    
    @echo "Running test:"
    @echo {{TEST}}
    @echo "--------------------------------"
    @odin run tests/{{TEST}}.odin -file
    @echo "--------------------------------"