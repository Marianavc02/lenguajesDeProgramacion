import Data.List (nub)
import Test.HUnit

-- Defino del tipo de datos 
data Prop = Const Bool
          | Var Char
          | Not Prop
          | And Prop Prop
          | Or Prop Prop
          | Cond Prop Prop
          | Bicond Prop Prop
          deriving Show

-- Proposiciones de ejemplo
p1, p2, p3, p4 :: Prop
p1 = And (Var 'A') (Not (Var 'A'))
p2 = Cond (And (Var 'A') (Var 'B')) (Var 'A')
p3 = Or (Var 'A') (Var 'B') 
p4 = Bicond (Var 'A') (Cond (Var 'A') (Var 'B'))

-- Función para evaluar una fórmula lógica
evaluar :: [(Char, Bool)] -> Prop -> Bool
evaluar _ (Const b) = b
evaluar vars (Var x) = case lookup x vars of
                         Just b -> b
                         Nothing -> error "Variable no encontrada"
evaluar vars (Not p) = not (evaluar vars p)
evaluar vars (And p q) = evaluar vars p && evaluar vars q
evaluar vars (Or p q) = evaluar vars p || evaluar vars q
evaluar vars (Cond p q) = not (evaluar vars p) || evaluar vars q
evaluar vars (Bicond p q) = evaluar vars (Cond p q) && evaluar vars (Cond q p)

-- Función para verificar si una proposición es una tautología
isT :: Prop -> Bool
isT p = and [evaluar vars p | vars <- posiblesAsignaciones (variables p)]
  where
    variables :: Prop -> [Char]
    variables (Const _) = []
    variables (Var x) = [x]
    variables (Not p) = variables p
    variables (And p q) = variables p ++ variables q
    variables (Or p q) = variables p ++ variables q
    variables (Cond p q) = variables p ++ variables q
    variables (Bicond p q) = variables p ++ variables q

    posiblesAsignaciones :: [Char] -> [[(Char, Bool)]]
    posiblesAsignaciones [] = [[]]
    posiblesAsignaciones (x:xs) = [(x, b):resto | b <- [False, True], resto <- posiblesAsignaciones xs]

-- Definimos las pruebas unitarias
tests :: Test
tests = TestList
    [ test1
    , test2
    , test3
    , testP1
    , testP2
    , testP3
    , testP4
    ]

-- Prueba 1: Verificar si una proposición verdadera es una tautología
test1 :: Test
test1 = TestCase $ assertEqual "Verificar si una fórmula verdadera es una tautología" True (isT (Const True))

-- Prueba 2: Verificar si "A -> A" es una tautología
test2 :: Test
test2 = TestCase $ assertEqual "Verificar si una fórmula 'A -> A' es una tautología" True (isT (Cond (Var 'A') (Var 'A')))

-- Prueba 3: Verificar si "A ^ -A" no es una tautología
test3 :: Test
test3 = TestCase $ assertEqual "Verificar si una fórmula 'A ^ -A' no es una tautología" False (isT (And (Var 'A') (Not (Var 'A'))))

-- Prueba para p1
testP1 :: Test
testP1 = TestCase $ assertEqual "Verificar si p1 es una tautología" False (isT p1)

-- Prueba para p2
testP2 :: Test
testP2 = TestCase $ assertEqual "Verificar si p2 es una tautología" True (isT p2)

-- Prueba para p3
testP3 :: Test
testP3 = TestCase $ assertEqual "Verificar si p3 es una tautología" False (isT p3)

-- Prueba para p4
testP4 :: Test
testP4 = TestCase $ assertEqual "Verificar si p4 es una tautología" False (isT p4) -- Cambiado a False basado en lógica

main :: IO Counts
main = do
    putStrLn "Evaluación de fórmulas:"
    putStrLn "p1 es tautología?" >> print (isT p1)
    putStrLn "p2 es tautología?" >> print (isT p2)
    putStrLn "p3 es tautología?" >> print (isT p3)
    putStrLn "p4 es tautología?" >> print (isT p4)
    runTestTT tests

