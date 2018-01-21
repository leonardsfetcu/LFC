%{
    int yylex();
	int yyerror(const char *msg);
	char msg[500];

    #include <string.h>
    #include <stdio.h>
    FILE *yyies=NULL;
    int operandUses=0;




    
    enum DataFlag
    {
    	SET,
    	UNSET,
    	INVALID
    };
    enum DataType
    {
    	INT,
    	FLOAT,
    	BOOL,
    	INVALID_TYPE
    };

    class tListObject
    {	
    private:
    	char*		string;
    	int			intValue;
    	float		floatValue;
    	bool		boolValue;
    	DataFlag	boolFlag;
    	DataFlag	intFlag;
    	DataFlag	floatFlag;
        DataType    type;

    public:
    	tListObject()
    	{
    		string = NULL;
    		intFlag = UNSET;
    		floatFlag = UNSET;
    		boolFlag = UNSET;
    	}
    
    	const char*	getString() const { return string; }
    	int			getIntVal() const { return intValue; }
        DataType    getType() const { return type; }
        void        setType(DataType type) { this->type=type;}
    	void		setIntFlag() { intFlag=SET;}
    	void		setFloatFlag() {floatFlag=SET;}
    	void		setBoolFlag() {boolFlag=SET;}
    	float		getFloatVal() const { return floatValue; }
    	bool		getBoolVal() const { return boolValue; }
    	DataFlag	getIntFlag() const { return intFlag; }
    	DataFlag	getFloatFlag() const { return floatFlag; }
    	DataFlag	getBoolFlag() const { return boolFlag; }
    	void		setString(const char* str)
    	{
    		if (string != NULL)
    		{
    			delete[] string;
    			string = NULL;
    		}
    
    		string = new char[strlen(str) + 1];
    		strcpy(string, str);
    
    	}
    	int setInt(int value)
    	{
    		if(floatFlag==SET||boolFlag==SET)
    		{
    			printf("trying to set multiple data types for \"%s\"\n",string);
    			return -1;
    		}
    		else
    		{
                intValue = value;
    			intFlag = SET;
                return 1;
    		}

    	}
    	int setFloat(float value)
    	{	
    		if(intFlag==SET||boolFlag==SET)
    		{
    			printf("trying to set multiple data types for \"%s\"\n",string);
    			return -1;
    		}
    		else
    		{
                floatValue = value;
    			floatFlag = SET;
                return 1;
    		}
    
    	}
    	int setBool(bool value)
    	{
    		if(intFlag==SET||floatFlag==SET)
    		{
    			printf("trying to set multiple data types for \"%s\"\n",string);
    			return -1;
    		}
    		else
    		{
    			boolFlag = SET;
           		boolValue = value;
                return 1;
    		}

    	}

    	~tListObject()
    	{
    		if (string != NULL)
    		{
    			delete[] string;
    			string = NULL;
    		}
    	}


    };

    struct Nod
    {
    	tListObject obj;
    	Nod *next;

    };


    Nod *head, *end;
    void showStats(const char* str)
    {
    	Nod* temp=head;

    	while(temp)
    	{
    		if(strcmp(temp->obj.getString(),str)==0)
    		{
    			break;
    		}
    		temp=temp->next;
    	}
    	printf("var name: %s\nintValue= %d\nfloatValue= %.2f\nboolValue= %d\nintFlag= %d\nfloatFlag= %d\nboolFlag= %d\n",
    	temp->obj.getString(),temp->obj.getIntVal(),temp->obj.getFloatVal(),temp->obj.getBoolVal(),temp->obj.getIntFlag(),temp->obj.getFloatFlag(),temp->obj.getBoolFlag());
    }
    DataFlag getDataFlag(const char* str,DataType type)
    {
    	Nod* temp = head;

    	while (temp)
    	{
    		if (strcmp(temp->obj.getString(), str) == 0)
    		{
    			break;
    		}
    		temp = temp->next;
    	}
    	switch (type)
    	{
    	case INT: return temp->obj.getIntFlag();
    		break;
    	case FLOAT: return temp->obj.getFloatFlag();
    		break;
    	case BOOL: return temp->obj.getBoolFlag();
    		break;
    	default: return INVALID;
    	}
    	return INVALID;
    }

    void addVariable(const char* name, DataType type)
    {
    	Nod* nod = new Nod;
    	nod->next = NULL;
    	nod->obj.setString(name);
    	nod->obj.setType(type);
        /*switch(type)
    	{
    		case INT: nod->obj.setIntFlag();
    		break;
    		case FLOAT: nod->obj.setFloatFlag();
    		break;
    		case BOOL: nod->obj.setBoolFlag();
    		break;
    		default: 
    		break;
    	}*/
        
    	if (head == NULL)
    	{
    		head = end = nod;
    	}
    	else
    	{
    		end->next = nod;
    		end = nod;
    	}
    }

    DataType getDataType(const char* str)
    {
    	Nod* temp = head;

    	while (temp)
    	{
    		if (strcmp(temp->obj.getString(), str) == 0)
    		{
    			return temp->obj.getType();
    		}
    		temp = temp->next;
    	}
        return INVALID_TYPE;
    }

    int setIntValue(const char* str, int value)
    {
    	Nod* temp = head;

    	while (temp)
    	{
    		if (strcmp(temp->obj.getString(), str) == 0)
    		{
    			return temp->obj.setInt(value);
    		}
    		temp = temp->next;
    	}
    	return -1;
    }

    int setBoolValue(const char* str, bool value)
    {
    	Nod* temp = head;

    	while (temp)
    	{
    		if (strcmp(temp->obj.getString(), str) == 0)
    		{
    			return temp->obj.setBool(value);
    		}
    		temp = temp->next;
    	}
    	return -1;
    }

    int setFloatValue(const char* str, float value)
    {
    	Nod* temp = head;

    	while (temp)
    	{
    		if (strcmp(temp->obj.getString(), str) == 0)
    		{
    			return temp->obj.setFloat(value);
    		}
    		temp = temp->next;
    	}
    	return -1;
    }

    int getIntVal(const char* str)
    {
    	Nod* temp = head;

    	while (temp)
    	{
    		if (strcmp(temp->obj.getString(), str) == 0)
    		{
    			return temp->obj.getIntVal();
    		}
    		temp = temp->next;
    	}
    }
    float getFloatVal(const char* str)
    {
    	Nod* temp = head;

    	while (temp)
    	{
    		if (strcmp(temp->obj.getString(), str) == 0)
    		{
    			return temp->obj.getFloatVal();
    		}
    		temp = temp->next;
    	}
    }
    bool getBoolVal(const char* str)
    {
    	Nod* temp = head;

    	while (temp)
    	{
    		if (strcmp(temp->obj.getString(), str) == 0)
    		{
    			return temp->obj.getBoolVal();
    		}
    		temp = temp->next;
    	}
    }
    int exists(const char* str)
    {
    	Nod* temp = head;
    	while (temp)
    	{
    		if (strcmp(temp->obj.getString(), str) == 0)
    		{
    			return 1;
    		}
    		temp = temp->next;
    	}
    	return -1;
    }


%}

%code requires
{
  struct Number
  {
    enum
    {
      INTEGER,FLOAT,BOOL,STRING
    } type;
    union
    {
      int intVal;
      float floatVal;
      bool boolVal;
      char *string;
    } u;
  };
}
%define api.value.type {struct Number}


%token TOK_PROG TOK_IF TOK_ELSE TOK_THEN TOK_GREATER TOK_EQUAL TOK_MULTIPLY TOK_CLOSE 
%token TOK_PRINT TOK_REPEAT TOK_UNTIL TOK_BOOL TOK_FLOAT TOK_PLUS TOK_DIVIDE TOK_END TOK_UNEQUAL
%token TOK_LOWER TOK_LOWER_EQUAL TOK_GREATER_EQUAL TOK_INT TOK_MINUS TOK_OPEN TOK_BEGIN TOK_EQUALEQUAL
   

%token <u.intVal>         TOK_NUMBER_INT
%token <u.floatVal>       TOK_NUMBER_FLOAT
%token <u.boolVal>        TOK_BOOL_VALUE
%token <u.string>         TOK_ID TOK_STRING
%type  <u>                Expression Operand



%start Start

%left TOK_PLUS TOK_MINUS
%left TOK_MULTIPLY TOK_DIVIDE

%%

Start:          TOK_PROG TOK_ID InstructionBlock
                ;

InstructionBlock:   
                TOK_BEGIN InstructionList TOK_END
                ;
InstructionList : 
				Instruction InstructionList
				|
				error InstructionList
				|
				;

Instruction:    TOK_INT TOK_ID ';'
                {
					if(exists($2)==1)
                    {
                        sprintf(msg,"(on line: %d): Variabila \"%s\" a fost deja declarata!", @1.first_line,$2);
	                    yyerror(msg);
	                    YYERROR;
                    }
                    else
                    {
                        addVariable($<u.string>2,INT);
                    }
                }
                |
                TOK_INT TOK_ID TOK_EQUAL Expression ';'
                {
                    if(exists($2)==1)
                    {
                        sprintf(msg,"(on line: %d): Variabila \"%s\" a fost deja declarata!", @1.first_line,$2);
	                    yyerror(msg);
	                    YYERROR;
                    }
                    else
                    {
                        fprintf(yyies,"\tsw\t\t$t%d, %s\n",--operandUses,$2);
                        addVariable($2,INT);
                        setIntValue($2,$<u.intVal>4);
                    }
                }
                |
                TOK_FLOAT TOK_ID ';'
                {
                    if(exists($2)==1)
                    {
                        sprintf(msg,"(on line: %d): Variabila \"%s\" a fost deja declarata!", @1.first_line,$2);
	                    yyerror(msg);
	                    YYERROR;
                    }
                    else
                    {
                        addVariable($<u.string>2,FLOAT);
                    }
                }
                |
                TOK_FLOAT TOK_ID TOK_EQUAL Expression ';'
                {
                    if(exists($2)==1)
                    {
                        sprintf(msg,"(on line: %d): Variabila \"%s\" a fost deja declarata!", @1.first_line,$2);
	                    yyerror(msg);
	                    YYERROR;
                    }
                    else
                    {
                        addVariable($2,FLOAT);
                        setFloatValue($2,$<u.floatVal>4);
                    }
                }
                |
                TOK_BOOL TOK_ID ';'
                {
                    if(exists($2)==1)
                    {
                        sprintf(msg,"(on line: %d): Variabila \"%s\" a fost deja declarata!", @1.first_line,$2);
	                    yyerror(msg);
	                    YYERROR;
                    }
                    else
                    {
                        addVariable($<u.string>2,BOOL);
                    }
                }
                |
                TOK_BOOL TOK_ID TOK_EQUAL Expression ';'
                {
                    if(exists($2)==1)
                    {
                        sprintf(msg,"(on line: %d): Variabila \"%s\" a fost deja declarata!", @1.first_line,$2);
	                    yyerror(msg);
	                    YYERROR;
                    }
                    else
                    {
                        addVariable($2,BOOL);
                        setBoolValue($2,$<u.boolVal>4);
                    }
                }
                |
                TOK_ID TOK_EQUAL Expression ';'
                {
                    if(exists($1)==1)
                    {
                        DataType varType=getDataType($1);
                        Number expr;
                        expr.type=$<type>3;

                        switch(varType)
                        {
                            case INT:
                            switch(expr.type)
                            {
                                case Number::INTEGER:
	                                fprintf(yyies,"\tsw\t\t$t%d, %s\n",operandUses-1,$<u.string>1);
                                    operandUses--;
                                break;
                                case Number::STRING:
                                if(exists($<u.string>3)==1)
                                {
                                    if(getDataType($<u.string>3)!=INT)
                                    {
                                        sprintf(msg,"(on line: %d): Imposibil de procesat expresii continand mai multe tipuri de date!", @1.first_line);
	                                    yyerror(msg);
	                                    YYERROR;    
                                    }
                                    else
                                    {
                                        fprintf(yyies,"\tlw\t\t$t0, %s\n",$<u.string>3);
	                                    fprintf(yyies,"\tsw\t\t$t0, %s\n",$1);

                                    }
                                }
                                else
                                {
                                    sprintf(msg,"(on line: %d): Variabila \"%s\" este folosita fara a fi declarata!", @1.first_line,$<u.string>3);
	                                yyerror(msg);
	                                YYERROR;
                                }
                                break;
                                default:
                                sprintf(msg,"(on line: %d): Imposibil de procesat expresii continand mai multe tipuri de date!", @1.first_line);
	                            yyerror(msg);
	                            YYERROR;    
                                break;
                            }
                            break;
                            case FLOAT:
                             switch(expr.type)
                            {
                                case Number::FLOAT:
                                    fprintf(yyies,"\tli.s\t$f0, %.4f\n",$<u.floatVal>3);
	                                fprintf(yyies,"\ts.s\t\t$f0, %s\n",$<u.string>1);
                                break;
                                case Number::STRING:
                                if(exists($<u.string>3)==1)
                                {
                                    if(getDataType($<u.string>3)!=FLOAT)
                                    {
                                        sprintf(msg,"(on line: %d): Imposibil de procesat expresii continand mai multe tipuri de date!", @1.first_line);
	                                    yyerror(msg);
	                                    YYERROR;    
                                    }
                                    else
                                    {
                                        fprintf(yyies,"\tl.s\t\t$f0, %s\n",$<u.string>3);
	                                    fprintf(yyies,"\ts.s\t\t$f0, %s\n",$1);
                                    }
                                }
                                else
                                {
                                    sprintf(msg,"(on line: %d): Variabila \"%s\" este folosita fara a fi declarata!", @1.first_line,$<u.string>3);
	                                yyerror(msg);
	                                YYERROR;
                                }
                                break;
                                default:
                                sprintf(msg,"(on line: %d): Imposibil de procesat expresii continand mai multe tipuri de date!", @1.first_line);
	                            yyerror(msg);
	                            YYERROR;    
                                break;
                            }
                            break;
                            case BOOL:
                            switch(expr.type)
                            {
                                case Number::BOOL:
                                    fprintf(yyies,"\tli\t\t$t0, %d\n",$<u.boolVal>3);
	                                fprintf(yyies,"\tsw\t\t$t0, %s\n",$<u.string>1);
                                break;
                                case Number::STRING:
                                if(exists($<u.string>3)==1)
                                {
                                    if(getDataType($<u.string>3)!=BOOL)
                                    {
                                        sprintf(msg,"(on line: %d): Imposibil de procesat expresii continand mai multe tipuri de date!", @1.first_line);
	                                    yyerror(msg);
	                                    YYERROR;    
                                    }
                                    else
                                    {
                                        fprintf(yyies,"\tlw\t\t$t0, %s\n",$<u.string>3);
	                                    fprintf(yyies,"\tsw\t\t$t0, %s\n",$1);
                                    }
                                }
                                else
                                {
                                    sprintf(msg,"(on line: %d): Variabila \"%s\" este folosita fara a fi declarata!", @1.first_line,$<u.string>3);
	                                yyerror(msg);
	                                YYERROR;
                                }
                                break;
                                default:
                                sprintf(msg,"(on line: %d): Imposibil de procesat expresii continand mai multe tipuri de date!", @1.first_line);
	                            yyerror(msg);
	                            YYERROR;    
                                break;
                            }
                            break;
                            
                            default: break;
                        }
                    }
                    else
                    {
                        sprintf(msg,"(on line: %d): Variabila \"%s\" este folosita fara a fi declarata!", @1.first_line,$1);
	                    yyerror(msg);
	                    YYERROR;
                    }
                }
                |
                TOK_PRINT Expression ';'
                {
                   switch($<type>2)
                   {
                       case Number::INTEGER:
	                    fprintf(yyies,"\tmove\t\t$a0, $t%d\n",--operandUses);
                        fprintf(yyies,"\tli\t\t\t$v0, 1\n");
	                    fprintf(yyies,"\tsyscall\n");
                       break;
                       case Number::FLOAT:
                        fprintf(yyies,"\tmov.s\t\t$f12, $f%d\n",--operandUses);
                       // fprintf(yyies,"\tli.s\t$f12, %.4f\n",$<u.floatVal>2);
                        fprintf(yyies,"\tli\t\t\t$v0, 2\n");
	                    fprintf(yyies,"\tsyscall\n");
                       break;
                       case Number::BOOL:
   	                    fprintf(yyies,"\tmove\t\t$a0, $t%d\n",--operandUses);
                       // fprintf(yyies,"\tli\t\t$a0, %d\n",$<u.floatVal>2);
                        fprintf(yyies,"\tli\t\t\t$v0, 1\n");
	                    fprintf(yyies,"\tsyscall\n");
                       break;
                       case Number::STRING:
                       if(exists($<u.string>2)==1)
                       {
                           switch(getDataType($<u.string>2))
                           {
                               case INT:
                                    fprintf(yyies,"\tlw\t\t$a0, %s\n",$<u.string>2);
	                                fprintf(yyies,"\tli\t\t$v0, 1\n");
                                    fprintf(yyies,"\tsyscall\n");
                                    fprintf(yyies,"\tla\t\t$a0, newLine\n");
                                    fprintf(yyies,"\tli\t\t$v0, 4\n");
                                    fprintf(yyies,"\tsyscall\n");

                               break;
                               case FLOAT:
                                    fprintf(yyies,"\tl.s\t\t$f12, %s\n",$<u.string>2);
	                                fprintf(yyies,"\tli\t\t$v0, 2\n");
                                    fprintf(yyies,"\tsyscall\n");
                                    fprintf(yyies,"\tla\t\t$a0, newLine\n");
                                    fprintf(yyies,"\tli\t\t$v0, 4\n");
                                    fprintf(yyies,"\tsyscall\n");
                               break;
                               case BOOL:
                                    fprintf(yyies,"\tlw\t\t$a0, %s\n",$<u.string>2);
	                                fprintf(yyies,"\tli\t\t$v0, 1\n");
                                    fprintf(yyies,"\tsyscall\n");
                                    fprintf(yyies,"\tla\t\t$a0, newLine\n");
                                    fprintf(yyies,"\tli\t\t$v0, 4\n");
                                    fprintf(yyies,"\tsyscall\n");
                               break;
                               default: 
                                sprintf(msg,"(on line: %d): Variabila \"%s\" este folosita fara a fi initializata!", @1.first_line,$<u.string>2);
	                            yyerror(msg);
	                            YYERROR;
                               break;
                           }
                       }
                       else
                       {
                            sprintf(msg,"(on line: %d): Variabila \"%s\" este folosita fara a fi declarata!", @1.first_line,$<u.string>2);
	                        yyerror(msg);
	                        YYERROR;
                       }
                       break;
                       default: break;
                   }
                }
                |
                TOK_PRINT TOK_STRING ';'
                {
                 
                }
                |
                TOK_IF TOK_OPEN Condition TOK_CLOSE TOK_THEN InstructionBlock
                {

                }
                |
                TOK_IF TOK_OPEN Condition TOK_CLOSE TOK_THEN InstructionBlock TOK_ELSE InstructionBlock
                {

                }
                |
                TOK_REPEAT InstructionBlock TOK_UNTIL TOK_OPEN Condition TOK_CLOSE ';'
                {

                }
                ;
Expression:
                Expression TOK_PLUS Expression
                {   
                    switch($<type>1)
                    {
                        case Number::INTEGER:

                            switch($<type>3)
                            {
                                case Number::INTEGER:
                                fprintf(yyies,"\tadd\t\t$t%d, $t%d, $t%d\n",operandUses-2,operandUses-2,operandUses-1);
                                operandUses--;
                                $<type>$=Number::INTEGER;
                                $<u.intVal>$=$<u.intVal>1+$<u.intVal>3;
                                break;
                                case Number::STRING:
                                break;
                                default:
                                sprintf(msg,"(on line: %d): Imposibil de procesat expresii continand mai multe tipuri de date!", @1.first_line);
	                            yyerror(msg);
	                            YYERROR;
                                break;
                            }

                        break;
                        case Number::FLOAT:

                            switch($<type>3)
                            {
                                case Number::FLOAT:
                                fprintf(yyies,"\tadd.s\t\t$f%d, $f%d, $f%d\n",operandUses-2,operandUses-2,operandUses-1);
                                operandUses--;
                                $<type>$=Number::FLOAT;
                                $<u.floatVal>$=$<u.floatVal>1+$<u.floatVal>3;
                                break;
                                case Number::STRING:
                                break;
                                default:
                                sprintf(msg,"(on line: %d): Imposibil de procesat expresii continand mai multe tipuri de date!", @1.first_line);
	                            yyerror(msg);
	                            YYERROR;
                                break;
                            }

                        break;
                        case Number::BOOL:

                            switch($<type>3)
                            {
                                default:
                                sprintf(msg,"(on line: %d): Imposibil de procesat expresii continand tipuri de date boolene!", @1.first_line);
	                            yyerror(msg);
	                            YYERROR;
                                break;
                            }

                        break;
                        case Number::STRING:

                            switch($<type>3)
                            {
                                case Number::INTEGER:
                                break;
                                case Number::FLOAT:
                                break;
                                case Number::BOOL:
                                break;
                                case Number::STRING:
                                break;
                                default: break;
                            }
                            
                        break;
                        default: break;
                    }
                }
                |
                Expression TOK_MINUS Expression
                {
                    switch($<type>1)
                    {
                        case Number::INTEGER:

                            switch($<type>3)
                            {
                                case Number::INTEGER:
                                break;
                                case Number::FLOAT:
                                break;
                                case Number::BOOL:
                                break;
                                case Number::STRING:
                                break;
                            }

                        break;
                        case Number::FLOAT:

                            switch($<type>3)
                            {
                                case Number::INTEGER:
                                break;
                                case Number::FLOAT:
                                break;
                                case Number::BOOL:
                                break;
                                case Number::STRING:
                                break;
                            }

                        break;
                        case Number::BOOL:

                            switch($<type>3)
                            {
                                case Number::INTEGER:
                                break;
                                case Number::FLOAT:
                                break;
                                case Number::BOOL:
                                break;
                                case Number::STRING:
                                break;
                            }

                        break;
                        case Number::STRING:

                            switch($<type>3)
                            {
                                case Number::INTEGER:
                                break;
                                case Number::FLOAT:
                                break;
                                case Number::BOOL:
                                break;
                                case Number::STRING:
                                break;
                            }
                            
                        break;
                    }
                }
                |
                Expression TOK_MULTIPLY Expression
                {
                   switch($<type>1)
                    {
                        case Number::INTEGER:

                            switch($<type>3)
                            {
                                case Number::INTEGER:
                                break;
                                case Number::FLOAT:
                                break;
                                case Number::BOOL:
                                break;
                                case Number::STRING:
                                break;
                            }

                        break;
                        case Number::FLOAT:

                            switch($<type>3)
                            {
                                case Number::INTEGER:
                                break;
                                case Number::FLOAT:
                                break;
                                case Number::BOOL:
                                break;
                                case Number::STRING:
                                break;
                            }

                        break;
                        case Number::BOOL:

                            switch($<type>3)
                            {
                                case Number::INTEGER:
                                break;
                                case Number::FLOAT:
                                break;
                                case Number::BOOL:
                                break;
                                case Number::STRING:
                                break;
                            }

                        break;
                        case Number::STRING:

                            switch($<type>3)
                            {
                                case Number::INTEGER:
                                break;
                                case Number::FLOAT:
                                break;
                                case Number::BOOL:
                                break;
                                case Number::STRING:
                                break;
                            }
                            
                        break;
                    }
                }
                |
                Expression TOK_DIVIDE Expression
                {
                    switch($<type>1)
                    {
                        case Number::INTEGER:

                            switch($<type>3)
                            {
                                case Number::INTEGER:
                                break;
                                case Number::FLOAT:
                                break;
                                case Number::BOOL:
                                break;
                                case Number::STRING:
                                break;
                            }

                        break;
                        case Number::FLOAT:

                            switch($<type>3)
                            {
                                case Number::INTEGER:
                                break;
                                case Number::FLOAT:
                                break;
                                case Number::BOOL:
                                break;
                                case Number::STRING:
                                break;
                            }

                        break;
                        case Number::BOOL:

                            switch($<type>3)
                            {
                                case Number::INTEGER:
                                break;
                                case Number::FLOAT:
                                break;
                                case Number::BOOL:
                                break;
                                case Number::STRING:
                                break;
                            }

                        break;
                        case Number::STRING:

                            switch($<type>3)
                            {
                                case Number::INTEGER:
                                break;
                                case Number::FLOAT:
                                break;
                                case Number::BOOL:
                                break;
                                case Number::STRING:
                                break;
                            }
                            
                        break;
                    }
                }
                |
                TOK_OPEN Expression TOK_CLOSE
                {

                }
                |
                Operand
                {
                    switch($<type>1)
                    {
                        case Number::INTEGER:             
                        fprintf(yyies,"\tli\t\t$t%d, %d\n",operandUses++,$<u.intVal>1);                        
                        $<type>$=Number::INTEGER;
                        $<u.intVal>$=$<u.intVal>1;
                        break;
                        case Number::FLOAT:
                        fprintf(yyies,"\tli.s\t\t$f%d, %.4f\n",operandUses++,$<u.floatVal>1);
                        $<type>$=Number::FLOAT;
                        $<u.floatVal>$=$<u.floatVal>1;
                        break;
                        case Number::BOOL:
                        fprintf(yyies,"\tli\t\t$t%d, %d\n",operandUses++,$<u.boolVal>1);
                        $<type>$=Number::BOOL;
                        $<u.boolVal>$=$<u.boolVal>1;
                        break;
                        case Number::STRING:
                        $<type>$=Number::STRING;
                        $<u.string>$=$<u.string>1;
                        break;

                        default: break;
                    }
                }
                ;
        
Operand:
                TOK_NUMBER_INT
                {
                    $<u.intVal>$=$<u.intVal>1;
                    $<type>$=Number::INTEGER;
                }
                |
                TOK_NUMBER_FLOAT
                {
                    $<u.floatVal>$=$<u.floatVal>1;
                    $<type>$=Number::FLOAT;
                }
                |
                TOK_BOOL_VALUE
                {
                    $<u.boolVal>$ = $<u.boolVal>1;
                    $<type>$ = Number::BOOL;
                }
                |
                TOK_ID
                {
                    $<u.string>$=$<u.string>1;
                    $<type>$=Number::STRING;
                }
                ;

Condition:     
                Expression TOK_EQUALEQUAL Expression
                |
                Expression TOK_UNEQUAL Expression
                |
                Expression TOK_GREATER Expression
                |
                Expression TOK_GREATER_EQUAL Expression
                |
                Expression TOK_LOWER Expression
                |
                Expression TOK_LOWER_EQUAL Expression
                |
                Expression
                ;

%%

int main() {
  //  yydebug=1;
    yyies=fopen("mips.s","w");
    fprintf(yyies, "\t.text\n\t.globl main\nmain:\n");

    int result = yyparse();
    fprintf(yyies,"\tli\t\t$v0, 10\n");
    fprintf(yyies,"\tsyscall\n");
    fprintf(yyies,"\t.data\n");
    Nod* temp=head;
    while(temp)
    {
        switch(getDataType(temp->obj.getString()))
        {
            case INT:fprintf(yyies,"%s:\t\t\t.word %d\n",temp->obj.getString(),temp->obj.getIntVal());
            break;
            case FLOAT:fprintf(yyies,"%s:\t\t\t.float %.1f\n",temp->obj.getString(),temp->obj.getFloatVal());
            break;
            case BOOL:fprintf(yyies,"%s:\t\t\t.byte %d\n",temp->obj.getString(),temp->obj.getBoolVal());
            break;
            default: break;
        }
        temp=temp->next;
    }
    fprintf(yyies,"newLine:\t\t.asciiz \"\\n\"");
	fclose(yyies);
    return 0;
}

int yyerror(const char *msg)
{
	printf("Error %s\n",msg);
	return 1;
}