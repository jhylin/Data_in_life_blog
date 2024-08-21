import chembl_downloader
from textwrap import dedent
from typing import Optional

def chembl_drugs(*drug: str, file_name: Optional[str] = None):

    """
    Obtain approved drugs' ChEMBL IDs, generic drug/small molecule names, max phases and canonical SMILES
    via using drug names only with an option to save dataframe as tsv files

    :param drug: Enter generic drug names in capital letters to search in ChEMBL database e.g. "AMLODIPINE"
    :param file_name: Enter file name if needed in order to save dataframe as a .tsv file in working directory
    :return: A dataframe of small molecules/drugs derived from ChEMBL database 
    along with their ChEMBL IDs, max phases and canonical SMILES
    """

    # dedent to remove leading whitespaces from every line
    # https://docs.python.org/3/library/textwrap.html#textwrap.dedent
    sql = dedent(
        f"""\
        SELECT
            MOLECULE_DICTIONARY.chembl_id,
            MOLECULE_DICTIONARY.pref_name,
            MOLECULE_DICTIONARY.max_phase,
            COMPOUND_STRUCTURES.canonical_smiles
        FROM MOLECULE_DICTIONARY
            JOIN COMPOUND_STRUCTURES ON MOLECULE_DICTIONARY.molregno == COMPOUND_STRUCTURES.molregno 
        WHERE molecule_dictionary.pref_name IN '{drug}'
    """
    ).strip().strip('\'').replace('\'(', '(')

    # default query uses the latest ChEMBL version
    df = chembl_downloader.query(sql)

    if file_name == None:
        return df
    else:
        # save df as .tsv files if a file name is added
        df.to_csv(f"{file_name}.tsv", sep='\t', index=False)
        return df