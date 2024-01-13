$PesterResult = Invoke-Pester -PassThru
if ($PesterResult.FailedCount -ne 0) {
    throw "There were $($PesterResult.FailedCount) failed tests."
}