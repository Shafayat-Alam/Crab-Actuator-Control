from setuptools import setup
import os
from glob import glob

package_name = 'actuator_driver'

setup(
    name=package_name,
    version='0.0.0',
    packages=[package_name],
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
        # This ensures your launch file is actually installed during build
        (os.path.join('share', package_name, 'launch'), glob('launch/*.py')),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='shafa',
    maintainer_email='shafa@todo.todo',
    description='Crab Robot Actuator and Motion Control',
    license='Apache License 2.0',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            # format: 'executable_name = package_name.filename:main_function'
            'actuator = actuator_driver.actuator:main',
            'crab_controller = actuator_driver.crab_controller:main',
            'crab = actuator_driver.crab:main',
        ],
    },
)